require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "trip_gear queries" do
    it "returns all gear and comments for a trip" do
      trip = create(:trip)
      trip_gear_1 = create(:trip_gear, trip_id: trip.id)
      trip_gear_2 = create(:trip_gear, trip_id: trip.id)
      query = (
        %(query {
          trip(id: #{trip.id}){
            name
            tripGears{
              comments
              gear{
                itemName
              }
            }
          }
        })
      )
      trip_gear = SearchAndRescueApiSchema.execute(query).as_json['data']
      expect(trip_gear['trip']['name']).to eq(trip.name)
      expect(trip_gear['trip']['tripGears'][0]['comments']).to eq(trip_gear_1.comments)
      expect(trip_gear['trip']['tripGears'][0]['gear']['itemName']).to eq(trip_gear_1.gear.item_name)
      expect(trip_gear['trip']['tripGears'][1]['comments']).to eq(trip_gear_2.comments)
      expect(trip_gear['trip']['tripGears'][1]['gear']['itemName']).to eq(trip_gear_2.gear.item_name)
    end
  end
end
