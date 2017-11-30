class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :user_books, dependent: :destroy
  has_many :books, through: :user_books
  has_many :buy_requests, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.class,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.class,
    foreign_key: :followed_id, dependent: :destroy
  has_many :followers, through: :passive_relationships
  has_many :following, through: :active_relationships, source: :followed
  validates :full_name, presence: true, length: {maximum: Settings.name.maximum_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.email.maximum_length},
    format: {with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: {minimum: Settings.password.minimum_length}
  has_secure_password

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  def authenticated? remember_token
    return false unless remember_digest
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  class << self
    def digest token
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create token, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end
