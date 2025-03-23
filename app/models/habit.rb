class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_logs, dependent: :destroy

  def done_today!
    HabitLog.create(habit: self, log_date: Date.today)
  end

  def done_today?
    HabitLog.find_by(habit: self, log_date: Date.today).present?
  end

  def streak
    logs_by_date = habit_logs.group(:log_date).count
    return 0 if logs_by_date.empty?

    today = Date.today
    streak = logs_by_date[today] ? 1 : 0
    days_ago = 1

    while logs_by_date[today - days_ago]
      streak += 1
      days_ago += 1
    end

    streak
  end
end
