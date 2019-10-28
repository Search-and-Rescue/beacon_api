class Mutations::EndTrip < Mutations::BaseMutation
  argument :id, ID, required: true

  field :trip, Types::TripType, null: false
  field :errors, [String], null: false

  def resolve(id:)
    trip = Trip.find(id)
    if trip.update(active: false)
      {
        trip: trip,
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
