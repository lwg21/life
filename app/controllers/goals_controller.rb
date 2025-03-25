class GoalsController < ApplicationController
  def index
    @goals = Goal.all
    @unlocks = Current.user.unlocks
  end
end
