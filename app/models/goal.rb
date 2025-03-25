class Goal < ApplicationRecord
  has_many :unlocks, dependent: :destroy
  has_many :users, through: :unlocks

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
end
