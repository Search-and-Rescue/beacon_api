module Types
  class TripGearType < Types::BaseObject
    field :id, ID, null: false
    field :trip, Types::TripType, null: false
    field :gear, Types::GearType, null: false
    field :comments, String, null: false
  end
end
