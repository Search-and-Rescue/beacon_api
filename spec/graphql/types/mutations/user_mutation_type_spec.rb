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

    it "should update a user" do
      user = create(:user)
      mutation = (
        %(mutation {
          updateUser(input: {
            id: #{user.id}
            name: "Billy",
            email: "billy@gmail.com",
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

      updated_user = SearchAndRescueApiSchema.execute(mutation).as_json['data']['updateUser']['user']
      expect(updated_user['id'].to_i).to eq(user.id)
      expect(updated_user['name']).to eq("Billy")
      expect(updated_user['email']).to eq("billy@gmail.com")
    end
  end
end
