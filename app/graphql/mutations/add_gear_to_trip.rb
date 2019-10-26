class Mutations::AddGearToTrip < Mutations::BaseMutation
  argument :trip_id, ID, required: true
  argument :gear_id, ID, required: true
  argument :comments, String, required: false

  field :trip_gear, Types::TripGearType, null: false
  field :errors, [String], null: false

  def resolve(**args)
    trip_gear = TripGear.new(args)
    if trip_gear.save
      {
        trip_gear: trip_gear,
        error: []
      }
    else
      {
        trip_gear: nil,
        errors: trip_gear.errors.full_messages
      }
    end
  end
end
