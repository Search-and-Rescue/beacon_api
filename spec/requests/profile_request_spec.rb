require 'rails_helper'

describe "User Profile" do
  before :each do
    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "returns a user's profile" do
    query = (
      %(query {
        user(id: #{@user.id}) {
          id
          name
          email
        }
      })
    )
    post "/graphql", params: { "query" => query }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    profile = JSON.parse(response.body, symbolize_names: true)[:data][:user]

    expect(response).to be_successful
    expect(profile[:id].to_i).to eq(@user.id)
    expect(profile[:name]).to eq(@user.name)
    expect(profile[:email]).to eq(@user.email)
  end

  it "creates a user's profile" do
    mutation = (
      %(mutation {
        createUser(input: {
          name: "Tyler",
          email: "tyler@gmail.com",
          address: "123 Rocky Rd",
          city: "Denver",
          state: "CO",
          zip: 80210
        }) {
          user {
            id
            name
            email
            address
          }
        }
      })
    )
    post "/graphql", params: { "query" => mutation }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    profile = JSON.parse(response.body, symbolize_names: true)[:data][:createUser][:user]

    expect(response).to be_successful
    expect(profile[:id].to_i).to eq(User.last.id)
    expect(profile[:name]).to eq("Tyler")
    expect(profile[:email]).to eq("tyler@gmail.com")
    expect(profile[:address]).to eq("123 Rocky Rd")
  end

  it "updates a user's profile" do
    user = create(:user)
    mutation = (
      %(mutation {
        updateUser(input: {
          id: #{user.id}
          name: "Tyler",
          email: "tyler@gmail.com",
          address: "123 Rocky Rd",
          city: "Denver",
          state: "CO",
          zip: 80210
        }) {
          user {
            id
            name
            email
            address
          }
        }
      })
    )
    post "/graphql", params: { "query" => mutation }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    profile = JSON.parse(response.body, symbolize_names: true)[:data][:updateUser][:user]

    expect(response).to be_successful
    expect(profile[:id].to_i).to eq(User.last.id)
    expect(profile[:name]).to eq("Tyler")
    expect(profile[:email]).to eq("tyler@gmail.com")
    expect(profile[:address]).to eq("123 Rocky Rd")
  end
end
