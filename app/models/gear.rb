class Gear < ApplicationRecord
  belongs_to :user
  has_many :trip_gears
  has_many :trips, through: :trip_gears
end
