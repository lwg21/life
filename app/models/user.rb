class User < ApplicationRecord
  # Authentication
  has_secure_password
  has_many :sessions, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }

  has_many :habits, dependent: :destroy
  has_many :habit_logs, through: :habits

  validates :email_address, uniqueness: true
  # validates :password, confirmation: true
  # validates :password_confirmation, presence: true
end
