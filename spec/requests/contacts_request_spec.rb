require 'rails_helper'

describe "User Emergency Contacts" do
  before :each do
    @user = create(:user)
    @contact_1 = create(:emergency_contact, user_id: @user.id)
    @contact_2 = create(:emergency_contact, user_id: @user.id)
  end

  it "returns a user's contacts" do
    query = (
      %(query {
        user(id: #{@user.id}) {
          id
          name
          email
          emergencyContacts {
            name
            phone
            email
          }
        }
      })
    )
    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    contacts = JSON.parse(response.body, symbolize_names: true)[:data][:user][:emergencyContacts]

    expect(response).to be_successful
    expect(contacts[0][:name]).to eq(@contact_1.name)
    expect(contacts[0][:phone]).to eq(@contact_1.phone)
    expect(contacts[0][:email]).to eq(@contact_1.email)
    expect(contacts[1][:name]).to eq(@contact_2.name)
    expect(contacts[1][:phone]).to eq(@contact_2.phone)
    expect(contacts[1][:email]).to eq(@contact_2.email)
  end

  it "updates an emergency contact" do
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
    post "/graphql", params: { "query" => mutation }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    updated_contact = EmergencyContact.find(contact.id)

    expect(response).to be_successful
    expect(updated_contact.name).to eq("Julie")
    expect(updated_contact.phone).to eq("232-233-3232")
    expect(updated_contact.email).to eq("julie@gmail.com")
  end

  it "creates an emergency contact" do
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

    post "/graphql", params: { "query" => mutation }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    contact = EmergencyContact.last

    expect(response).to be_successful
    expect(contact.name).to eq("Julie")
    expect(contact.phone).to eq("232-233-3232")
    expect(contact.email).to eq("julie@gmail.com")
  end
end
