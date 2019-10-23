require 'rails_helper'

describe "User's Trips'" do
  before :each do
    @user = create(:user)
    @trip_1 = create(:trip, name: "trip 1", user_id: @user.id)
    @trip_2 = create(:trip, name: "trip 2", user_id: @user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
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

  it "returns a user's trips" do
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
end
