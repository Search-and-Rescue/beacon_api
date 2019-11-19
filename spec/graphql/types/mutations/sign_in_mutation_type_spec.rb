require 'rails_helper'

RSpec.describe Types::MutationType do
  describe "sign in" do
    before :each do
      @user = create(:user, password: "password")
    end

    def perform(args = {})
      Mutations::SignInUser.new(object: nil, context: { session: {} }).resolve(args)
    end

    it "should log in with valid credentials" do
      result = perform(email: @user.email, password: "password")
      expect(result[:token].present?).to be(true)
      expect(result[:user][:id].to_i).to be(@user.id)
    end

    it "should not log in with invalid email" do
      result = perform(email: "user@email.com", password: "password")
      expect(result[:token].present?).to be(false)
      expect(result[:error]).to eq("Email or password is incorrect")
    end

    it "should not log in with invalid password" do
      result = perform(email: @user.email, password: "passwOrd")
      expect(result[:token].present?).to be(false)
      expect(result[:error]).to eq("Email or password is incorrect")
    end
  end
end
