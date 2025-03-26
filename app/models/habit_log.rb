class HabitLog < ApplicationRecord
  belongs_to :habit

  # after_create :check_goals

  def check_goals
    # TODO
    puts "CHECKING GOALS"
    check_goal(:streak_day_3)
  end

  private

  # TODO: Move logic to different model or service object?
  def check_goal(goal_code)
    case goal_code
    when :streak_day_3
      goal = Goal.find_by(code: goal_code)
      puts "Checking for #{goal.name}"
      longest_streak = habit.longest_streak
      if longest_streak >= 3
        puts "Unlocked #{goal.name}!"
        # TODO: Create an Unlock instance (for the Goal and User)
      end
    end
  end
end
