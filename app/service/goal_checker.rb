class GoalChecker
  def initialize(user)
    @user = user
  end

  def check_goals
    goals = Goal.where.not(id: @user.goals.select(:goal_id))
    goals.each { |goal| @user.unlock(goal) if check_goal(goal) }
  end

  private

  def check_goal(goal)
    case goal.code
    when "streak_day_3"
      @user.habits.any? { |habit| habit.longest_streak >= 3 }
    when "streak_day_7"
      @user.habits.any? { |habit| habit.longest_streak >= 7 }
    when "streak_day_15"
      @user.habits.any? { |habit| habit.longest_streak >= 15 }
    when "streak_day_30"
      @user.habits.any? { |habit| habit.longest_streak >= 30 }
    else
      false
    end
  end
end
