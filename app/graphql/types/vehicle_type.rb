module Types
  class VehicleType < Types::BaseObject
    field :id, ID, null: false
    field :make, String, null: false
    field :model, String, null: false
    field :year, Integer, null: false
    field :color, String, null: false
    field :state, String, null: false
    field :license_plate, String, null: true
    field :user, Types::UserType, null: false
  end
end
