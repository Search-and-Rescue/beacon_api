class Mutations::AddVehicleToTrip < Mutations::BaseMutation
  argument :trip_id, ID, required: true
  argument :vehicle_id, ID, required: true

  field :vehicle, Types::VehicleType, null: true
  field :trip, Types::TripType, null: true

  def resolve(**args)
    trip = Trip.find(args[:trip_id])
    vehicle = Vehicle.find(args[:vehicle_id])
    if trip.update(vehicle_id: args[:vehicle_id])
      {
        trip: trip,
        vehicle: vehicle,
        error: []
      }
    else
      {
        trip: nil,
        errors: trip.errors.full_messages
      }
    end
  end
end
