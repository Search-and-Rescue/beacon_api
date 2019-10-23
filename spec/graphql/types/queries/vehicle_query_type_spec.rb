require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "vehicle queries" do
    it "should return all a user's vehicles" do
      user = create(:user)
      create_pair(:vehicle, user_id: user.id)

      query = (
        %(query {
          user(id: #{user.id}) {
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

      vehicles = SearchAndRescueApiSchema.execute(query).as_json['data']['user']['vehicles']

      expect(vehicles.length).to eq(2)
    end
  end
end
