class Goal < ApplicationRecord
  has_many :unlocks, dependent: :destroy
  has_many :users, through: :unlocks
end
