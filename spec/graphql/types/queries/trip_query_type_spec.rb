require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "trip queries" do
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
