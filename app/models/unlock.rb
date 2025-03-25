class Unlock < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  validates :user_id, uniqueness: { scope: :goal_id, message: "has already unlocked this goal" }
end
