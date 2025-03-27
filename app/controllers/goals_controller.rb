class GoalsController < ApplicationController
  def index
    @goals = Goal.all
    @unlocks_data = Current.user.unlocks.pluck(:goal_id, :seen_at).to_h
  end

  def show
    @goal = Goal.find(params[:id])
    unlock = Unlock.find_by(goal: @goal, user: Current.user)
    unlock.update(seen_at: Time.now) if unlock
    redirect_to goals_path
  end
end
