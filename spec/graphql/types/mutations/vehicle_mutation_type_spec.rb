require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "vehicle mutations" do

    it "should create a vehicle" do
      user = create(:user)

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

    it "should update a vehicle" do
      user = create(:user)
      vehicle = create(:vehicle, user_id: user.id)

      mutation = (
        %(mutation {
          updateVehicle(input: {
            id: #{vehicle.id}
            make: "Dodge",
            model: "Ram",
            year: 2015,
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

      updated_vehicle = SearchAndRescueApiSchema.execute(mutation).as_json['data']['updateVehicle']['vehicle']
      expect(updated_vehicle.length).to eq(5)
      expect(updated_vehicle['year']).to eq(2015)
    end

    it 'removes a vehicle' do
      user = create(:user)
      vehicle = create(:vehicle, user_id: user.id)

      mutation = (
        %(mutation {
          removeVehicle( input: {
            id: #{vehicle.id} }){
            vehicle {
              id
              make
              model
              year
              color
              licensePlate
            }
          }
        })
      )

      SearchAndRescueApiSchema.execute(mutation).as_json

      expect(user.vehicles.length).to eq(0)
    end
  end
end
