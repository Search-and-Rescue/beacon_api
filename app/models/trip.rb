class Trip < ApplicationRecord
  belongs_to :user
  has_many :trip_contacts, dependent: :destroy
  has_many :emergency_contacts, through: :trip_contacts
  has_many :trip_gears, dependent: :destroy
  has_many :gears, through: :trip_gears
  has_one :vehicle

  validates_presence_of :name
end
