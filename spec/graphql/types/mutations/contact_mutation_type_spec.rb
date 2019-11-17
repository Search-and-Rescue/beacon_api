require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'emergency_contacts' do
    it "should create a emergency contact for a user" do
      user = create(:user)
      mutation = (
        %(mutation{
          createContact(input: {
            userId: #{user.id}
            name: "Julie"
            phone: "232-233-3232"
            email: "julie@gmail.com"
          }) {
            clientMutationId
          }
        })
      )

      SearchAndRescueApiSchema.execute(mutation).as_json
      expect(EmergencyContact.last.name).to eq("Julie")
      expect(EmergencyContact.last.phone).to eq("232-233-3232")
      expect(EmergencyContact.last.email).to eq("julie@gmail.com")
    end

    it "should update a contact" do
      user = create(:user)
      contact = create(:emergency_contact, user_id: user.id)
      mutation = (
        %(mutation{
          updateContact(input: {
            id: #{contact.id}
            name: "Julie"
            phone: "232-233-3232"
            email: "julie@gmail.com"
          }) {
            clientMutationId
          }
        })
      )

      SearchAndRescueApiSchema.execute(mutation).as_json
      expect(EmergencyContact.last.name).to eq("Julie")
      expect(EmergencyContact.last.phone).to eq("232-233-3232")
      expect(EmergencyContact.last.email).to eq("julie@gmail.com")
    end

    it "should remove a contact" do
      user = create(:user)
      contact = create(:emergency_contact, user_id: user.id)
      mutation = (
        %(mutation{
          removeContact(input: {
            id: #{contact.id}
          }) {
            clientMutationId
          }
        })
      )

      SearchAndRescueApiSchema.execute(mutation).as_json
      expect(user.emergency_contacts.length).to eq(0)
    end

    it "should not remove a contact if missing info" do
      user = create(:user)
      contact = create(:emergency_contact, user_id: user.id)
      mutation = (
        %(mutation{
          removeContact(input: {
            id:
          }) {
            clientMutationId
          }
        })
      )

      response = SearchAndRescueApiSchema.execute(mutation).as_json["errors"]
      expect(response[0]["message"]).to eq("Argument 'id' on InputObject 'RemoveContactInput' has an invalid value. Expected type 'Int!'.")
    end
  end
end
