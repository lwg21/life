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

    today = Date.today
    @habits = Current.user.habits

    logs_by_date = @habit.habit_logs
      .group(:log_date)
      .count

    @calendar_data = {
      today: today,
      logs: logs_by_date,
      habits_count: @habits.length
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
    @habit.log(Date.today)

    Current.user.check_goals

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

  def destroy
    habit = Habit.find(params[:id])
    habit.destroy
    redirect_to root_path, notice: "#{habit.name} was successfully destroyed."
  end

  private

  def habit_params
    params.expect(habit: :name)
  end

  def set_calendar_data
    today = Date.today
    @habits = Current.user.habits

    logs_by_date = Current.user.habit_logs
      .where(log_date: today.beginning_of_month..today.end_of_month)
      .group(:log_date)
      .count

    @calendar_data = {
      today: today,
      logs: logs_by_date,
      habits_count: @habits.length
    }
  end
end
