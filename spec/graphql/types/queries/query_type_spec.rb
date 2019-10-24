require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'users' do
    it "should return all users" do
       create_pair(:user)
       query = (
         %(query {
           users {
             id
             name
             email
           }
         })
       )

       users = SearchAndRescueApiSchema.execute(query).as_json['data']['users']
       expect(users.length).to eq(2)
    end

    it "should return a user" do
      user = create(:user)
      query = (
        %(query {
          user(id: #{user.id}) {
            id
            name
            email
          }
        })
      )
      results = SearchAndRescueApiSchema.execute(query).as_json['data']['user']
      expect(results['id'].to_i).to eq(user.id)
      expect(results['name']).to eq(user.name)
    end
  end

  describe 'emergency_contacts' do
    it "should return a users emergency_contacts" do
      user = create(:user)
      contact_1 = create(:emergency_contact, user_id: user.id)
      contact_2 = create(:emergency_contact, user_id: user.id)

      query = (
        %(query {
          user(id: #{user.id}) {
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
      contacts = SearchAndRescueApiSchema.execute(query).as_json['data']['user']['emergencyContacts']
      expect(contacts[0]['name']).to eq(contact_1.name)
      expect(contacts[0]['phone']).to eq(contact_1.phone)
      expect(contacts[0]['email']).to eq(contact_1.email)
      expect(contacts[1]['name']).to eq(contact_2.name)
      expect(contacts[1]['phone']).to eq(contact_2.phone)
      expect(contacts[1]['email']).to eq(contact_2.email)
    end
    it "should return a single emergency_contact and associated user" do
      user = create(:user)
      contact_1 = create(:emergency_contact, user_id: user.id)

      query = (
        %(query {
          emergencyContact(id: #{contact_1.id}) {
            id
            name
            phone
            email
            user {
              name
              phone
              email
            }
          }
        })
      )
      contact = SearchAndRescueApiSchema.execute(query).as_json['data']['emergencyContact']
      expect(contact['name']).to eq(contact_1.name)
      expect(contact['email']).to eq(contact_1.email)
      expect(contact['phone']).to eq(contact_1.phone)
      expect(contact['user']['name']).to eq(user.name)
    end
  end
end
