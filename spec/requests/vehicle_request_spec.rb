require 'rails_helper'

describe "User's Vehicles" do
  before :each do
    @user = create(:user)
    @vehicle_1 = create(:vehicle, user_id: @user.id)
    @vehicle_2 = create(:vehicle, user_id: @user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "returns a user's vehicles" do
    query = (
      %(query {
        user(id: #{@user.id}) {
          vehicles {
            make
            model
            year
            color
            licensePlate
          }
        }
      })
    )

    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    vehicles = JSON.parse(response.body, symbolize_names: true)[:data][:user][:vehicles]

    expect(response).to be_successful
    expect(vehicles[0][:make]).to eq(@vehicle_1.make)
    expect(vehicles[1][:make]).to eq(@vehicle_2.make)
  end

  it "returns a single vehicle" do
    query = (
      %(query {
        vehicle(id: #{@vehicle_1.id}) {
          make
          model
        }
      })
    )
    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    vehicle = JSON.parse(response.body, symbolize_names: true)[:data][:vehicle]

    expect(response).to be_successful
    expect(vehicle[:make]).to eq(@vehicle_1.make)
    expect(vehicle[:model]).to eq(@vehicle_1.model)
  end
end
