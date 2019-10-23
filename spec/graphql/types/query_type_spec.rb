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

  describe "trips" do
    it "should return all a user's trips" do
      user = create(:user)
      create_pair(:trip, user_id: user.id)
      query = (
        %(query {
          user(id: #{user.id}) {
            trips {
              name
            }
          }
        })
      )
      trips = SearchAndRescueApiSchema.execute(query).as_json['data']['user']['trips']
      expect(trips.length).to eq(2)
    end

    it "should return a single trip" do
      trip_1 = create(:trip, name: "trip_1")
      query = (
        %(query {
          trip(id: #{trip_1.id}) {
            name
          }
        })
      )
      trip = SearchAndRescueApiSchema.execute(query).as_json['data']['trip']
      expect(trip['name']).to eq(trip_1.name)
    end
  end
end
