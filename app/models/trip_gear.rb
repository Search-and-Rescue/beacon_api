class TripGear < ApplicationRecord
  belongs_to :trip
  belongs_to :gear

  validates_presence_of :trip_id
  validates_presence_of :gear_id
end
