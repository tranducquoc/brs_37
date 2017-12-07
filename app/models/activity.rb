class Activity < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  scope :arrange, ->{order(created_at: :desc)}
end
