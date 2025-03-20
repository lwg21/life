class HabitsController < ApplicationController
  def index
    @today = Date.today
    @habits = Current.user.habits

    habit_logs_grouped_by_date = Current.user.habit_logs
      .select { |l| (@today.beginning_of_month..@today.end_of_month).include?(l.log_date) }
      .group_by { |h| h.log_date }
      .transform_values! { |v| v.count }

    @calendar_data = {
      today: @today,
      logs: habit_logs_grouped_by_date,
      habits_count: @habits.count
    }
  end

  def new
    @habit = Habit.new
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.user = Current.user
    if @habit.save
      redirect_to :root, notice: "Habit created"
    else
      render :new, status: :unprocessable_entity
    end
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

  private

  def habit_params
    params.expect(habit: :name)
  end
end
