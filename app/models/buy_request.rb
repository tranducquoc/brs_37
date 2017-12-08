class BuyRequest < ApplicationRecord
  belongs_to :user
  belongs_to :book
  scope :sort_by_time, ->{order(created_at: :desc)}
  scope :sort_by_status, ->{order(:request_status)}
  enum request_status: %i(pending aproved reject)
end
