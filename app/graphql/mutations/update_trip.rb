class Mutations::UpdateTrip < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :user_id, ID, required: true
  argument :name, String, required: true
  argument :activity_type, String, required: false
  argument :starting_point, String, required: false
  argument :ending_point, String, required: false
  argument :start_date, String, required: false
  argument :start_time, String, required: false
  argument :end_date, String, required: false
  argument :end_time, String, required: false
  argument :notification_date, String, required: false
  argument :notification_time, String, required: false
  argument :traveling_companions, Integer, required: false

  field :trip, Types::TripType, null: true
  field :errors, [String], null: false

  def resolve(**attributes)
    trip = Trip.find(attributes[:id])
    if trip.update!(attributes)
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
