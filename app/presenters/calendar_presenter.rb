class CalendarPresenter
  attr_reader :date_range

  def initialize(user, options = {})
    @user = user
    @today = Date.today
    @date_range = @today.beginning_of_month..@today.end_of_month
    if options[:habit]
      @logs = load_logs_for_habit(options[:habit])
      @habits_count = 1
      @level_max = 5
    else
      @logs = load_all_logs
      @habits_count = user.habits.count
      @level_max = 5
    end
  end

  def load_all_logs
    @user
      .habit_logs
      .where(log_date: @date_range)
      .group(:log_date)
      .count
  end

  def load_logs_for_habit(habit)
    @user
      .habit_logs
      .where(log_date: @date_range, habit: habit)
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
    return 0 if @logs[date].nil?

    case @habits_count
    when 0 then 0
    when 1 then 3
    else
      (@logs[date].fdiv(@habits_count) * @level_max).ceil
    end
  end

  def no_log_today?(date)
    @logs[date] == 0 && date.today?
  end
end
