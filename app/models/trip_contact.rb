class TripContact < ApplicationRecord
  belongs_to :emergency_contact
  belongs_to :trip
end
