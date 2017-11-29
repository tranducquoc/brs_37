class Book < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :book_categories, dependent: :destroy
  has_many :buy_requests, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :categories, through: :book_categories
  has_many :users, through: :user_books
end
