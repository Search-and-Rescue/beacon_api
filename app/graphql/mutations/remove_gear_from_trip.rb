class Mutations::RemoveGearFromTrip < Mutations::BaseMutation
  argument :gear_id, ID, required: true
  argument :trip_id, ID, required: true

  field :trip_gear, Types::TripGearType, null: false
  field :errors, [String], null: false

  def resolve(**args)
    trip_gear = TripGear.where(args).first
    trip_gear.destroy
    {
      trip_gear: trip_gear,
      errors: []
    }
  end
end
