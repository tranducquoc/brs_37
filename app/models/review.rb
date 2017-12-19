class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :comments, dependent: :destroy
  scope :arrange, ->{order(created_at: :desc)}
end
