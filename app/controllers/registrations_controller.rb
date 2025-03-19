class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: [ :new, :create ]
  rate_limit to: 5, within: 3.minutes, only: :create, with: -> { redirect_to new_registration_url, alert: "Try again later." }

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity, alert: "Try another email address or password."
    end
  end

  private

  def user_params
    params.expect(user: [ :email_address, :password, :password_confirmation ])
  end
end
