require 'rails_helper'

describe "User Profile" do
  before :each do
    @user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  it "gets a user's profile" do

    get "/api/v1/profile", params: { "id" => "#{@user.id}" }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    profile = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(profile[:name]).to eq("Scruffy McAnderson")
  end

  it "creates a user's profile" do

    post "/api/v1/profile/new", params: { "name" => "Baxter McRuffin",
    "address" => "123 Main St", "city" => "Denver", "state" => "CO", "zip" => 80804, "email" => "mcruffin@gmail.com", "password_digest" => "password" }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    user_id = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(user_id.class).to eq(Integer)
  end

  it "updates a user's profile" do

    patch "/api/v1/profile/edit", params: { "name" => "Baxter McDog" }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

		updated_profile = JSON.parse(response.body, symbolize_names: true)

		expect(response).to be_successful
		expect(updated_profile[:name]).to eq("Baxter McDog")
  end
end
