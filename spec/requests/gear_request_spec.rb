require 'rails_helper'

describe "User's Gear" do
  before :each do
    @user = create(:user)
    @food = create(:gear, user_id: @user.id)
    @sleeping_bag = create(:gear, user_id: @user.id)
    @water = create(:gear, user_id: @user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "returns a user's gear" do
    query = (
      %(query {
        user(id: #{@user.id}) {
          gear {
            itemName
          }
        }
      })
    )

    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    gear = JSON.parse(response.body, symbolize_names: true)[:data][:user][:gear]

    expect(response).to be_successful
    expect(gear[0][:itemName]).to eq(@food.item_name)
    expect(gear[1][:itemName]).to eq(@sleeping_bag.item_name)
    expect(gear[2][:itemName]).to eq(@water.item_name)
  end

  it "returns a single piece of gear" do

    query = (
      %(query {
        gear(id: #{@sleeping_bag.id}) {
          itemName
        }
      })
    )

    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    sleeping_bag = JSON.parse(response.body, symbolize_names: true)[:data][:gear]

    expect(response).to be_successful
    expect(sleeping_bag[:itemName]).to eq(@sleeping_bag.item_name)
  end

  it "creates a piece of gear" do

    query = (
      %(mutation {
        createGear(input: {
          itemName: "Avalance Beacon",
          userId: #{@user.id}
        }){
          gear {
            itemName
          }
        }
      })
    )

    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    new_gear = JSON.parse(response.body, symbolize_names: true)[:data][:createGear][:gear]

    expect(response).to be_successful
    expect(new_gear[:itemName]).to eq("Avalance Beacon")
  end

  it "updates a piece of gear" do

    query = (
      %(mutation {
        updateGear(input: {
          id: #{@sleeping_bag.id},
          itemName: "0 degrees sleeping bag"
        }){
          gear {
            itemName
          }
        }
      })
    )

    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    updated_gear = JSON.parse(response.body, symbolize_names: true)[:data][:updateGear][:gear]

    expect(response).to be_successful
    expect(updated_gear[:itemName]).to eq("0 degrees sleeping bag")
  end

  it "delete's a piece of gear" do

    query = (
      %(mutation {
        removeGear( input: {
          id: #{@food.id} }){
          gear {
            id
            itemName
          }
        }
      })
    )

    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(@user.gear.length).to eq(2)
  end
end
