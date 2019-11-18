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
          }
        })
      )

      result = SearchAndRescueApiSchema.execute(mutation).as_json['data']['signInUser']
      expect(result["token"].present?).to be(true)
    end
  end
end
