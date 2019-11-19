require 'rails_helper'

describe "User Login" do
  before :each do
    @user = create(:user, password: "password")
  end

  it "logs in and returns a token with valid credentials" do
    mutation =
    %(mutation {
      signInUser(input: {
        email: "#{@user.email}",
        password: "password"
      }) {
        user{
          id
        }
        token
      }
    })
    post "/graphql", params: { "query" => mutation }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    result = JSON.parse(response.body, symbolize_names: true)[:data][:signInUser]
    expect(result[:user][:id].to_i).to eq(@user.id)
    expect(session[:token].present?).to be(true)
  end

  it "does not log in or return a token with invalid credentials" do
    mutation =
    %(mutation {
      signInUser(input: {
        email: "#{@user.email}",
        password: "PasswOrd"
      }) {
        user{
          id
        }
        token
      }
    })
    post "/graphql", params: { "query" => mutation }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(session[:token].present?).to be(false)
  end

end
