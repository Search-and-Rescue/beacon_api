require 'rails_helper'

RSpec.describe Types::QueryType do
  describe 'users' do
    it "should create a user" do
      mutation = (
        %(mutation {
          createUser(input: {
            name: "Tyler",
            email: "tyler@gmail.com",
            address: "123 Rocky Rd",
            city: "Denver",
            state: "CO",
            zip: 80210
          }) {
            user {
              id
              name
              email
              address
            }
          }
        })
      )

      user = SearchAndRescueApiSchema.execute(mutation).as_json['data']['createUser']['user']
      expect(user['name']).to eq("Tyler")
      expect(user['email']).to eq("tyler@gmail.com")
      expect(user['address']).to eq("123 Rocky Rd")
    end
  end
end
