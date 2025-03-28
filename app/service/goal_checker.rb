class GoalChecker
  def initialize(user)
    @user = user
  end

  def check_goals
    goals = Goal.where.not(id: @user.goals.select(:goal_id))
    goals.each { |goal| @user.unlock(goal) if check_goal(goal) }
    binding.irb
  end

  private

  def check_goal(goal)
    case goal.category
    when "1:streak"
      @user.habits.any? { |habit| habit.longest_streak >= goal.target_value }
    else
      false
    end
  end
end
