class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: [ :new, :create ]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to root_path
    else
      Rails.logger.info(@user.errors.full_messages)
      Rails.logger.info(@user.errors.inspect)
      render :new, status: :unprocessable_entity, alert: "Try another email address or password."
      # redirect_to new_registration_path, alert: "Try another email address or password."
    end
  end

  private

  def user_params
    params.expect(user: [ :email_address, :password, :password_confirmation ])
  end
end
