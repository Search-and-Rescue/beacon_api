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
end