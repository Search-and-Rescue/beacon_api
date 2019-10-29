class Mutations::AddContactToTrip < Mutations::BaseMutation
  argument :emergency_contact_id, ID, required: true
  argument :trip_id, ID, required: true

  field :emergency_contact, Types::EmergencyContactType, null: true
  field :trip, Types::TripType, null: true

  def resolve(**args)
    trip_contact = TripContact.new(args)
    if trip_contact.save
      {
        trip_contact: trip_contact,
        trip: trip_contact.trip,
        emergency_contact: trip_contact.emergency_contact,
        error: []
      }
    else
      {
        trip_contact: nil,
        trip: nil,
        emergency_contact: nil,
        errors: trip_contact.errors.full_messages
      }
    end
  end
end
