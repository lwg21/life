class GoalsController < ApplicationController
  def index
    @goals = Goal.all
    @unlocked_goal_ids = Current.user.goals.pluck(:id)
  end
end
