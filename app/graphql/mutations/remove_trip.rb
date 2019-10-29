class Mutations::RemoveTrip < Mutations::BaseMutation
  argument :id, Integer, required: true

  field :trip, Types::TripType, null: true

  def resolve(id:)
    trip = Trip.find(id)
    trip.destroy
    {
      trip: trip,
      errors: []
    }
  end
end
