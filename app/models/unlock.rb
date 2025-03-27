class Unlock < ApplicationRecord
  belongs_to :user
  belongs_to :goal

  scope :unseen, -> { where(seen_at: nil) }

  validates :user_id, uniqueness: { scope: :goal_id, message: "has already unlocked this goal" }

  def mark_seen
    update!(seen_at: DateTime.current)
  end
end
