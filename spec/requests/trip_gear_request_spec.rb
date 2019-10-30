require 'rails_helper'

describe "Trip Gear" do
  before :each do
    @trip_gear = create(:trip_gear)
    @trip = create(:trip)
    @gear = create(:gear)
  end

  it "should return gear and comments for a trip" do
    query = (
      %(query {
        trip(id: #{@trip_gear.trip.id}){
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

    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    results = JSON.parse(response.body, symbolize_names: true)[:data][:trip]
    expect(response).to be_successful
    expect(results[:name]).to eq(@trip_gear.trip.name)
    expect(results[:tripGears][0][:comments]).to eq(@trip_gear.comments)
    expect(results[:tripGears][0][:gear][:itemName]).to eq(@trip_gear.gear.item_name)
  end

  it "should add gear and comments to a trip" do
    mutation = (
      %(mutation{
        addGearToTrip(input: {
          tripId: #{@trip.id}
          gearId: #{@gear.id}
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

    post "/graphql", params: { "query" => mutation }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    results = JSON.parse(response.body, symbolize_names: true)[:data][:addGearToTrip]
    expect(response).to be_successful
    expect(results[:tripGear][:comments]).to eq("This is a test")
    expect(results[:tripGear][:gear][:itemName]).to eq(@gear.item_name)
    expect(results[:tripGear][:trip][:name]).to eq(@trip.name)
  end

  it "should remove gear from to a trip" do
    trip_gear = TripGear.create(
      comments: "Test",
      trip_id: @trip.id,
      gear_id: @gear.id
    )

    mutation = (
      %(mutation{
        removeGearFromTrip(input: {
          gearId: #{@gear.id}
          tripId: #{@trip.id}
        }) {
          tripGear{
            gear{
              itemName
            }
          }
        }
      })
    )

    post "/graphql", params: { "query" => mutation }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    results = JSON.parse(response.body, symbolize_names: true)[:data][:removeGearFromTrip]
    expect(response).to be_successful
    expect(results[:tripGear][:gear][:itemName]).to eq(@gear.item_name)
    expect(TripGear.where(trip_id: @trip.id, gear_id: @gear.id).first).to eq(nil)
  end

  it "shouldn't remove gear from to a trip SAD" do
    trip_gear = TripGear.create(
      comments: "Test",
      trip_id: @trip.id,
      gear_id: @gear.id
    )

    mutation = (
      %(mutation{
        removeGearFromTrip(input: {
          tripId: #{@trip.id}
        }) {
          tripGear{
            gear{
              itemName
            }
          }
        }
      })
    )

    post "/graphql", params: { "query" => mutation }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    results = JSON.parse(response.body, symbolize_names: true)[:errors]
    expect(response).to be_successful
    expect(results[0][:message]).to eq("Argument 'gearId' on InputObject 'RemoveGearFromTripInput' is required. Expected type ID!")
  end

  it "shouldn't add gear from to a trip SAD" do
    trip_gear = TripGear.create(
      comments: "Test",
      trip_id: @trip.id,
      gear_id: @gear.id
    )

    mutation = (
      %(mutation{
        addGearToTrip(input: {
          tripId: #{@trip.id}
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

    post "/graphql", params: { "query" => mutation }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    results = JSON.parse(response.body, symbolize_names: true)[:errors]
    expect(response).to be_successful
    expect(results[0][:message]).to eq("Argument 'gearId' on InputObject 'AddGearToTripInput' is required. Expected type ID!")
  end
end
