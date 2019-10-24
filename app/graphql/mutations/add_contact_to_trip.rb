class Mutations::AddContactToTrip < Mutations::BaseMutation
  argument :emergency_contact_id, Integer, required: true
  argument :trip_id, Integer, required: true

  def resolve(**args)
    trip_contact = TripContact.new(args)
    if trip_contact.save
      {
        trip_contact: trip_contact,
        error: []
      }
    else
      {
        trip_contact: nil,
        errors: trip.errors.full_messages
      }
    end
  end
end
