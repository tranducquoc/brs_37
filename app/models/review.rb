class Review < ApplicationRecord
  belongs_to :book
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :content, presence: true
end
