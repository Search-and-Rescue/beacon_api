require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "trip_gear mutations" do
    it "should add gear and comments to a trip" do
      user = create(:user)
      trip = create(:trip, user_id: user.id)
      gear = create(:gear, user_id: user.id)

      mutation = (
        %(mutation{
          addGearToTrip(input: {
            tripId: #{trip.id}
            gearId: #{gear.id}
            comments: "This is a test"
          }) {
            tripGear{
              comments
              gear{
                itemName
              }
              trip{
                name
              }
            }
          }
        })
      )
      response = SearchAndRescueApiSchema.execute(mutation).as_json['data']['addGearToTrip']
      expect(response['tripGear']['trip']['name']).to eq(trip.name)
      expect(response['tripGear']['comments']).to eq("This is a test")
      expect(response['tripGear']['gear']['itemName']).to eq(gear.item_name)
    end

    it "should remove gear from a trip" do
      user = create(:user)
      trip = create(:trip, user_id: user.id)
      gear = create(:gear, user_id: user.id)
      trip_gear = TripGear.create(
        comments: "Test",
        trip_id: trip.id,
        gear_id: gear.id
      )

      mutation = (
        %(mutation{
          removeGearFromTrip(input: {
            gearId: #{gear.id}
            tripId: #{trip.id}
          }) {
            tripGear{
              gear{
                itemName
              }
            }
          }
        })
      )
      response = SearchAndRescueApiSchema.execute(mutation).as_json['data']['removeGearFromTrip']
      expect(response['tripGear']['gear']['itemName']).to eq(gear.item_name)
      expect(TripGear.where(trip_id: trip.id, gear_id: gear.id).first).to eq(nil)
    end
  end
end
