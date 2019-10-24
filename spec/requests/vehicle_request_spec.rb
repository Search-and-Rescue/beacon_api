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

  it "creates a vehicle" do

    query = (
      %(mutation {
        createVehicle(input: {
          make: "Dodge",
          model: "Ram",
          year: 2005,
          color: "silver",
          licensePlate: "CYE 990",
          userId: #{@user.id}
        }){
          vehicle {
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

    new_vehicle = JSON.parse(response.body, symbolize_names: true)[:data][:createVehicle][:vehicle]

    expect(response).to be_successful
    expect(new_vehicle[:make]).to eq("Dodge")
    expect(new_vehicle[:model]).to eq("Ram")
    expect(new_vehicle[:year]).to eq(2005)
  end

  it "updates a vehicle" do

    query = (
      %(mutation {
        updateVehicle(input: {
          id: #{@vehicle_1.id}
          make: "Dodge",
          model: "Ram",
          year: 2015,
          color: "silver",
          licensePlate: "CYE 990",
          userId: #{@user.id}
        }){
          vehicle {
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

    new_vehicle = JSON.parse(response.body, symbolize_names: true)[:data][:updateVehicle][:vehicle]

    expect(response).to be_successful
    expect(new_vehicle[:make]).to eq("Dodge")
    expect(new_vehicle[:model]).to eq("Ram")
    expect(new_vehicle[:year]).to eq(2015)
  end

  it "removes a vehicle" do

    query = (
      %(mutation {
          removeVehicle( input: {
            id: #{@vehicle_1.id} }){
            vehicle {
              id
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

    JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(@user.vehicles.length).to eq(1)
  end
end
