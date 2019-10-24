class EmergencyContact < ApplicationRecord
  belongs_to :user
  has_many :trips, through: :trip_contacts

  validates :name,  presence: true
  validates :phone, presence: true
  validates :email, presence: true
end
