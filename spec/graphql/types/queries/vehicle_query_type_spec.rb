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

    it "should return a single vehicle" do
      vehicle_1 = create(:vehicle, make: "dodge", model: "ram")

      query = (
        %(query {
          vehicle(id: #{vehicle_1.id}) {
            make
            model
            user {
              id
              name
            }
          }
        })
      )
      vehicle = SearchAndRescueApiSchema.execute(query).as_json['data']['vehicle']
      expect(vehicle['make']).to eq(vehicle_1.make)
      expect(vehicle['model']).to eq(vehicle_1.model)
    end
  end
end
