class User < ApplicationRecord
  has_many :trips
  has_many :emergency_contacts

  validates :email, uniqueness: true, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :zip, presence: true
  validates_presence_of :name, :address, :city

  enum experience_level: ["beginner", "moderate", "advanced"]
end
