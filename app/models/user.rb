class User < ApplicationRecord
  has_many :trips
  
  validates :email, uniqueness: true, presence: true
  validates :state, presence: true, length: { is: 2 }
  validates :zip, presence: true, numericality: true, length: { is: 5 }
  validates_presence_of :name, :address, :city

  enum experience_level: ["beginner", "moderate", "advanced"]
end
