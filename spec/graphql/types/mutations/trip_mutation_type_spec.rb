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

    it "can end a trip SAD path" do
      trip = create(:trip)

      mutation = (
        %(mutation{
          endTrip(input: {

          }) {
            trip{
              name
              active
            }
          }
        })
      )

      results = SearchAndRescueApiSchema.execute(mutation).as_json['errors']

      expect(results[0]["message"]).to eq("Argument 'id' on InputObject 'EndTripInput' is required. Expected type ID!")
    end

    it "should add a vehicle to a trip" do
      trip = create(:trip)
      vehicle = create(:vehicle)
      mutation = (
        %(mutation{
        addVehicleToTrip(input: {
          tripId: #{trip.id}
          vehicleId: #{vehicle.id}
          }) {
            trip{
              id
              name
            }
            vehicle{
              id
              make
              model
            }
          }
        })
      )
      SearchAndRescueApiSchema.execute(mutation).as_json['data']
      trip.reload
      expect(trip.vehicle_id).to eq(vehicle.id)
    end

    it "should remove a trip from the database" do
      trip = create(:trip)

      mutation = (
        %(mutation{
          removeTrip(input: {
            id: #{trip.id}
          }) {
            trip{
              name
            }
          }
        })
      )
      results = SearchAndRescueApiSchema.execute(mutation).as_json['data']['removeTrip']
      expect(results['trip']['name']).to eq(trip.name)
      expect(Trip.exists?(trip.id)).to eq(false)
    end
  end
end
