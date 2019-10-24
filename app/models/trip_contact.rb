class TripContact < ApplicationRecord
  belongs_to :emergency_contact
  belongs_to :trip

  validates_presence_of :emergency_contact_id
  validates_presence_of :trip_id
end
