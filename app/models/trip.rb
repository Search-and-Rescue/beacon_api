class Trip < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :trip_contacts
  has_many :emergency_contacts, through: :trip_contacts

  validates_presence_of :name
end
