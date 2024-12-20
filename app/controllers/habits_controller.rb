class HabitsController < ApplicationController
  def index
    @habits = Habit.all
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
