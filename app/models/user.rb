class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  before_create :create_activation_digest
  before_save{email.downcase!}
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
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.password.minimum_length}
  has_secure_password

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attributes remember_digest: nil
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest
    BCrypt::Password.new(digest).is_password? token
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
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

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
