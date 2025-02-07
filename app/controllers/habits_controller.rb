class HabitsController < ApplicationController
  def index
    @habits = Current.user.habits
    @date = Date.today

    # Calendar
    monthly_habits = Current.user.habit_logs
      .select { |l| (@date.beginning_of_month..@date.end_of_month).include?(l.log_date) }
      .group_by { |h| h.log_date.day }
      .transform_values! { |v| v.count }

    @calendar_data = {
      date: @date,
      data: monthly_habits,
      top: @habits.count
    }
  end

  def mark_done
    @habit = Habit.find(params[:id])
    @habit.done_today!
    redirect_to root_path
  end

  def reset_day
    HabitLog.where(log_date: Date.today).destroy_all
    redirect_to root_path
  end
end
