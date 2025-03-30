class HabitCollectionPresenter
  attr_reader :date_range, :logs

  def initialize(user)
    @user = user
    @today = Date.today
    @date_range = (@today - 6)..@today
    @habits = user.habits
    @logs = load_logs
    # @streaks = scan_for_streaks
  end

  def load_logs
    @user
      .habit_logs
      .order(log_date: :asc)
      .group(:habit_id, :log_date)
      .count
  end

  def habit_count(habit, date)
    @logs[[ habit.id, date ]]
  end

  def done_today?(habit)
    @logs[[ habit.id, @today ]]
  end

  def total_count(habit)
    @logs.sum { |key, value| key[0] == habit.id ? value : 0 }
  end

  def current_streak(habit)
    return 0 unless @logs.any? { |k, v| k[0] == habit.id }

    streak = @logs[[ habit.id, @today ]] ? 1 : 0
    days_ago = 1

    while @logs[[ habit.id, @today - days_ago ]]
      streak += 1
      days_ago += 1
    end

    streak
  end

  def longest_streak(habit)
    habit_logs = @logs.select { |k, v| k[0] == habit.id }.map { |k, v| k[1] }
    return 0 if habit_logs.empty?

    streaks = []
    streak = 1

    habit_logs.each_index do |index|
      next if index.zero?

      if (habit_logs[index] - habit_logs[index - 1]).to_i == 1
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
