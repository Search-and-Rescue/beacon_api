require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "trip mutations" do
    it "should create a trip" do
      user = create(:user)
      trip = create(:trip, user_id: user.id)

      mutation = (
        %(mutation {
          createTrip(input: {
            name: "Tyler's Big Adventure"
            userId: #{user.id}
          }){
            clientMutationId
          }
        })
      )
      new_trip = SearchAndRescueApiSchema.execute(mutation).as_json['data']['createTrip']
      expect(new_trip.length).to eq(1)
    end

    it "should create a trip" do
      user = create(:user)
      trip = create(:trip, user_id: user.id)

      mutation = (
        %(mutation {
          updateTrip(input: {
            id: #{trip.id}
            name: "Tyler's Little Adventure"
            userId: #{user.id}
          }){
            clientMutationId
          }
        })
      )
      updated_trip = SearchAndRescueApiSchema.execute(mutation).as_json['data']['updateTrip']
      expect(updated_trip.length).to eq(1)
    end

    it "can end a trip" do
      trip = create(:trip)

      mutation = (
        %(mutation{
          endTrip(input: {
            id: #{trip.id}
          }) {
            trip{
              name
              active
            }
          }
        })
      )
      results = SearchAndRescueApiSchema.execute(mutation).as_json['data']['endTrip']
      trip.reload
      expect(trip.active).to eq(false)
    end
  end
end
