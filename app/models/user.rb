class User < ApplicationRecord
  # Authentication
  has_secure_password
  has_many :sessions, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :habits, dependent: :destroy
  has_many :habit_logs, through: :habits

  has_many :unlocks, dependent: :destroy
  has_many :goals, through: :unlocks

  validates :email_address, uniqueness: true
end
