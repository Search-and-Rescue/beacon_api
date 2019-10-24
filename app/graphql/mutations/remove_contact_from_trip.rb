class Mutations::RemoveContactFromTrip < Mutations::BaseMutation
  argument :emergency_contact_id, ID, required: true
  argument :trip_id, ID, required: true

  field :emergency_contact, Types::EmergencyContactType, null: true
  field :trip, Types::TripType, null: true

  def resolve(**args)
    trip_contact = TripContact.where(args).first
    trip_contact.destroy
    {
      trip_contact: trip_contact,
      errors: []
    }
  end
end
