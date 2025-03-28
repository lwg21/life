class GoalsController < ApplicationController
  def index
    @user_id = Current.user.id
    @goals = Goal.all.includes(:unlocks).order(:category, :target_value)
  end

  def show
    @goal = Goal.find(params[:id])
    unlock = Unlock.find_by(goal: @goal, user: Current.user)
    unlock.update(seen_at: Time.now) if unlock
    redirect_to goals_path
  end
end
