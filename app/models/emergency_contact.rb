class EmergencyContact < ApplicationRecord
  belongs_to :user

  validates :name, uniqueness: false, presence: true
  validates :phone, presence: true
  validates :email, presence: true
end
