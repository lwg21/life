class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_logs, dependent: :destroy

  def done_today!
    HabitLog.create(habit: self, log_date: Date.today)
  end

  def done_today?
    HabitLog.find_by(habit: self, log_date: Date.today).present?
  end
end
