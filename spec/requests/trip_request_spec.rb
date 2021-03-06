require 'rails_helper'

describe "User's Trips'" do
  before :each do
    @user = create(:user)
    @trip_1 = create(:trip, name: "trip 1", user_id: @user.id)
    @trip_2 = create(:trip, name: "trip 2", user_id: @user.id)

    allow_any_instance_of(GraphqlController).to receive(:current_user).and_return(@user)
  end

  it "returns a user's trips" do
    query = (
      %(query {
        user(id: #{@user.id}) {
          trips {
            name
          }
        }
      })
    )
    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    trips = JSON.parse(response.body, symbolize_names: true)[:data][:user][:trips]

    expect(response).to be_successful
    expect(trips[0][:name]).to eq(@trip_1.name)
    expect(trips[1][:name]).to eq(@trip_2.name)
  end

  it "returns a single trip" do
    query = (
      %(query {
        trip(id: #{@trip_1.id}) {
          name
        }
      })
    )
    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    trip = JSON.parse(response.body, symbolize_names: true)[:data][:trip]

    expect(response).to be_successful
    expect(trip[:name]).to eq(@trip_1.name)
  end

  it "creates a trip" do
    query = (
      %(mutation {
        createTrip(input: {
          name: "Tyler's Big Adventure"
          userId: #{@user.id}
          }) {
          clientMutationId
        }
      })
    )

    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    new_trip = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
  end

  it "updates a trip" do
    query = (
      %(mutation {
        updateTrip(input: {
          id: #{@trip_1.id}
          name: "Tyler's Little Adventure"
          userId: #{@user.id}
          })
          {
          clientMutationId
        }
      })
    )

    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    updated_trip = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
  end

  it "returns trips that are active and not checked in" do
    trip = Trip.create(
      name: "Maroon Bells",
      activity_type: Faker::Job.key_skill,
      starting_point: "Maroon Bells Trailhead",
      ending_point: Faker::Company.name,
      start_date: Date.current - 1.day,
      start_time: Time.current - 12.hours,
      end_date: Date.current,
      end_time: Time.current - 6.hours,
      notification_date: Date.current,
      notification_time: Time.current - 2.hours,
      traveling_companions: rand(1..2),
      user_id: @user.id,
      active: true
    )
    query = (
      %(query {
        activeTrips {
          name
          user {
            name
          }
        }
      })
    )
    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    results = JSON.parse(response.body, symbolize_names: true)[:data][:activeTrips]

    expect(response).to be_successful
    expect(results.length).to eq(1)
    expect(results[0][:name]).to eq(trip.name)
    expect(results[0][:user][:name]).to eq(@user.name)
  end

  it "should set a trips active status to false" do
    trip = create(:trip)
    query = (
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
    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    results = JSON.parse(response.body, symbolize_names: true)[:data][:endTrip]
    expect(results[:trip][:name]).to eq(trip.name)
    expect(results[:trip][:active]).to eq(false)
    trip.reload
    expect(trip.active).to eq(false)
  end

  it "adds a vehicle to a trip" do
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
    post "/graphql", params: { "query" => mutation }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    results = JSON.parse(response.body, symbolize_names: true)[:data][:addVehicleToTrip]
    expect(results[:trip][:id].to_i).to eq(trip.id)
    expect(results[:vehicle][:id].to_i).to eq(vehicle.id)
    trip.reload
    expect(trip.vehicle_id).to eq(vehicle.id)
  end

  it "removes a trip from the database" do
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
    post "/graphql", params: { "query" => mutation }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    results = JSON.parse(response.body, symbolize_names: true)[:data][:removeTrip]
    expect(results[:trip][:name]).to eq(trip.name)
    expect(Trip.exists?(trip.id)).to eq(false)
  end
end
