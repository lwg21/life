class HabitsController < ApplicationController
  def index
    user = Current.user
    @calendar = CalendarPresenter.new(user)
    @habits_presenter = HabitCollectionPresenter.new(user)
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
    user = Current.user
    @habit = user.habits.find(params[:id])
    @habit.log(Date.today)
    user.check_goals

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json do
        @calendar = CalendarPresenter.new(user)
        @habits_presenter = HabitCollectionPresenter.new(user)

        render json: {
          calendar: render_to_string(partial: "calendar", formats: :html, locals: { calendar: @calendar }),
          habit: render_to_string(partial: "habit", formats: :html, locals: { habit: @habit, habits_presenter: @habits_presenter })
        }
      end
    end
  end

  def reset_day
    Current.user.habit_logs.where(log_date: Date.today).destroy_all
    redirect_to root_path, status: :see_other
  end

  def destroy
    habit = Habit.find(params[:id])
    if habit.user == Current.user
      habit.destroy
      redirect_to root_path, notice: "#{habit.name} was successfully destroyed."
    else
      redirect_to (request.referrer || root_path), notice: "You are not authorized to perform this action."
    end
  end

  private

  def habit_params
    params.expect(habit: :name)
  end

  def calendar_data(options = {})
    date = options[:date] || Date.today
    count = options[:count] || Current.user.habits.count

    {
      today: date,
      habits_count: count,
      logs: Current.user.habit_logs
        .where(log_date: date.beginning_of_month..date.end_of_month)
        .group(:log_date)
        .count
    }
  end

  def habits_data(options = {})
    date = options[:date] || Date.today
    date_range = (date - 6)..(date)

    {
      date_range: date_range,
      logs: Current.user.habit_logs
        .where(log_date: date_range)
        .group(:habit_id, :log_date)
        .count
    }
  end
end
