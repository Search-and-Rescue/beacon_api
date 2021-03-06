module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :address, String, null: false
    field :city, String, null: false
    field :state, String, null: false
    field :zip, Integer, null: false
    field :phone, String, null: true
    field :email, String, null: false
    field :password_digest, String, null: true
    field :allergies, String, null: true
    field :experience_level, String, null: true
    field :birth_date, String, null: true
    field :weight, Integer, null: true
    field :height, String, null: true
    field :hair_color, String, null: true
    field :skin_color, String, null: true
    field :gender, String, null: true
    field :cosar_card, Boolean, null: true

    field :emergency_contacts, [Types::EmergencyContactType], null: true
    field :trips, [Types::TripType], null: true
    field :vehicles, [Types::VehicleType], null: true
    field :gear, [Types::GearType], null: true
  end
end
