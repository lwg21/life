class HabitsController < ApplicationController
  def home
    set_calendar_data
  end

  def index
    @today = Date.today
    @date_range = (@today - 6)..@today
    @habits = Current.user.habits

    @logs_by_habit_and_date = Current.user.habit_logs
      .where(log_date: @date_range)
      .group(:habit_id, :log_date)
      .count
  end

  def show
    @habit = Habit.find(params[:id])
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

    set_calendar_data

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json
    end
  end

  def reset_day
    HabitLog.where(log_date: Date.today).destroy_all
    redirect_to root_path
  end

  private

  def habit_params
    params.expect(habit: :name)
  end

  def set_calendar_data
    today = Date.today
    @habits = Current.user.habits

    habit_logs_grouped_by_date = Current.user.habit_logs
      .where(log_date: today.beginning_of_month..today.end_of_month)
      .group(:log_date)
      .count

    @calendar_data = {
      today: today,
      logs: habit_logs_grouped_by_date,
      habits_count: @habits.length
    }
  end
end
