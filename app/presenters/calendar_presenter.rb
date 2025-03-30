class CalendarPresenter
  attr_reader :date_range

  def initialize(user)
    @user = user
    @today = Date.today
    @date_range = @today.beginning_of_month..@today.end_of_month
    @level_max = 5
    @habits_count = user.habits.count
    @logs = load_logs
  end

  def load_logs
    @logs = @user
      .habit_logs
      .where(log_date: @date_range)
      .group(:log_date)
      .count
  end

  def week_days
    Date::DAYNAMES.rotate(1).map(&:first)
  end

  def padding_days_start
    @today.beginning_of_month.cwday - 1
  end

  def padding_days_end
    7 - @today.end_of_month.cwday
  end

  def level(date)
    return 0 if @logs[date].nil? || @habits_count.zero?

    (@logs[date].fdiv(@habits_count) * @level_max).ceil
  end

  def no_log_today?(date)
    @logs[date] == 0 && date.today?
  end
end
