class User < ApplicationRecord
  # Authentication
  has_secure_password
  has_many :sessions, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :habits
  has_many :habit_logs, through: :habits
end
