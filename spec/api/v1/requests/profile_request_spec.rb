require 'rails_helper'

describe "User Profile" do
  it "gets a user's profile" do

    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    get "/api/v1/profile", params: { "id" => "#{user.id}" }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    profile = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(profile[:name]).to eq("Scruffy McAnderson")
  end

  it "updates a user's profile" do

		user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    patch "/api/v1/profile/edit", params: { "name" => "Baxter McDog" }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

		new_profile = JSON.parse(response.body, symbolize_names: true)

		expect(response).to be_successful
		expect(new_profile[:name]).to eq("Baxter McDog")
  end
end
