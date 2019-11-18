require 'rails_helper'

RSpec.describe Types::MutationType do
  describe "sign in" do
    before :each do
      @user = create(:user, password: "password")
    end

    it "should log in" do
      mutation = (
        %(mutation {
          signInUser(input: {
            email: "#{@user.email}"
            password: "password"
          }) {
            token
            user {
              id
            }
          }
        })
      )

      result = SearchAndRescueApiSchema.execute(mutation).as_json['data']['signInUser']
      expect(result["token"].present?).to be(true)
      expect(result["user"]["id"].to_i).to be(@user.id)
    end
  end
end
