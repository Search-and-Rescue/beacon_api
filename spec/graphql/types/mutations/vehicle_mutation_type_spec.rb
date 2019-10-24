require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "vehicle mutations" do
    it "should create a vehicle" do
      user = create(:user)
      vehicle = create(:vehicle, user_id: user.id)

      mutation = (
        %(mutation {
          createVehicle(input: {
            make: "Dodge",
            model: "Ram",
            year: 2005,
            color: "silver",
            licensePlate: "CYE 990",
            userId: #{user.id}
          }){
            vehicle {
              make
              model
              year
              color
              licensePlate
            }
          }
        })
      )

      new_vehicle = SearchAndRescueApiSchema.execute(mutation).as_json['data']['createVehicle']['vehicle']
      expect(new_vehicle.length).to eq(5)
      expect(new_vehicle['make']).to eq("Dodge")

    end

    it "should create a vehicle" do
      user = create(:user)
      vehicle = create(:vehicle, user_id: user.id)

      updated_vehicle = SearchAndRescueApiSchema.execute(mutation).as_json['data']['updateVehicle']
      expect(updated_vehicle.length).to eq(1)
    end
  end
end
