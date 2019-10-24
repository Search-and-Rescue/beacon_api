class Mutations::AddContactToTrip < Mutations::BaseMutation
  argument :emergency_contact_id, ID, required: true
  argument :trip_id, ID, required: true

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
        errors: trip_contact.errors.full_messages
      }
    end
  end
end
