class User < ApplicationRecord
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
  has_secure_password
end
