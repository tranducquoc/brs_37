class Activity < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  scope :arrange, ->{order(created_at: :desc)}
  scope :activity_feed, ->(followed_ids, id){where "user_id IN (?) OR user_id = ?", followed_ids, id}
  delegate :ids, to: :User, prefix: "user_id"
end
