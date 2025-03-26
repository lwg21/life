class GoalChecker
  def initialize(user)
    @user = user
  end

  def check_goals
    goals = Goal.where.not(id: @user.goals.select(:goal_id))
    goals.each do |goal|
      @user.unlock(goal) if check_goal(goal)
    end
  end

  private

  def check_goal(goal)
    case goal.code
    when "streak_day_3"
      puts "Checking 3 day streak"
      @user.habits.any? { |habit| habit.longest_streak >= 3 }
    when "streak_day_7"
      puts "Checking 7 day streak"
      @user.habits.any? { |habit| habit.longest_streak >= 7 }
    when "streak_day_15"
      puts "Checking 15 day streak"
      @user.habits.any? { |habit| habit.longest_streak >= 15 }
    else
      false
    end
  end
end
