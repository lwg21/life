class Habit < ApplicationRecord
  belongs_to :user
  has_many :habit_logs, dependent: :destroy

  def done_today!
    HabitLog.create(habit: self, log_date: Date.today)
  end

  # TODO: check if needed
  def done_today?
    HabitLog.find_by(habit: self, log_date: Date.today).present?
  end

  def log(date)
    HabitLog.create(habit: self, log_date: date)
  end

  def log_range(date_range)
    date_range.each do |date|
      HabitLog.create(habit: self, log_date: date)
    end
  end

  def current_streak
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

  def longest_streak
    log_dates = habit_logs.order(log_date: :asc).pluck(:log_date)
    return 0 if log_dates.empty?

    streaks = []
    streak = 1

    log_dates.each_index do |index|
      next if index.zero?

      if (log_dates[index] - log_dates[index - 1]).to_i == 1
        streak += 1
      else
        streaks << streak
        streak = 1
      end
    end
    streaks << streak

    streaks.max
  end
end
