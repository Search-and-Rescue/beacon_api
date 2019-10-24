require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'trip_contacts' do
    it "should add a contact to a trip" do
      user = create(:user)
      contact = create(:emergency_contact, user_id: user.id)
      trip = create(:trip, user_id: user.id)
      mutation = (
        %(mutation{
          addContactToTrip(input: {
            tripId: #{trip.id}
            emergencyContactId: #{contact.id}
          }) {
            clientMutationId
          }
        })
      )

      SearchAndRescueApiSchema.execute(mutation).as_json
      trip_contact = TripContact.last
      expect(trip_contact.emergency_contact_id).to eq(contact.id)
      expect(trip_contact.trip_id).to eq(trip.id)
    end

    it "should remove a contact from a trip" do
      user = create(:user)
      contact = create(:emergency_contact, user_id: user.id)
      trip = create(:trip, user_id: user.id)
      TripContact.create(
        emergency_contact_id: contact.id,
        trip_id: trip.id
      )
      mutation = (
        %(mutation{
          removeContactFromTrip(input: {
            tripId: #{trip.id}
            emergencyContactId: #{contact.id}
          }) {
            clientMutationId
          }
        })
      )

      SearchAndRescueApiSchema.execute(mutation).as_json
      trip_contact = TripContact.last
      expect(trip_contact).to be(nil)
    end
  end
end
