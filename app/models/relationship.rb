class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.class
  belongs_to :followed, class_name: User.class
end
