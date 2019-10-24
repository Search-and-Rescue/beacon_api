require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "gear mutations" do

    xit "should create a piece of gear" do
      user = create(:user)

      mutation = (
        %(mutation {
          createGear(input: {
            itemName: "JetBoil",
            userId: #{user.id}
          }){
            gear {
              itemName
            }
          }
        })
      )

      new_gear = SearchAndRescueApiSchema.execute(mutation).as_json['data']['createGear']['gear']
      expect(new_gear.length).to eq(1)
      expect(new_gear['item_name']).to eq("JetBoil")
    end

    xit "should update a piece of gear" do
      user = create(:user)
      gear = create(:gear, user_id: user.id)

      mutation = (
        %(mutation {
          updateGear(input: {
            id: #{gear.id}
            itemName: "water",
            userId: #{user.id}
          }){
            gear {
              itemName
            }
          }
        })
      )

      updated_gear = SearchAndRescueApiSchema.execute(mutation).as_json['data']['updateGear']['gear']
      expect(updated_gear.length).to eq(1)
      expect(updated_gear['item_name']).to eq("water")
    end

    xit 'removes a piece of gear' do
      user = create(:user)
      gear = create(:gear, user_id: user.id)

      mutation = (
        %(mutation {
          removeGear( input: {
            id: #{gear.id} }){
            gear {
              id
              itemName
            }
          }
        })
      )

      SearchAndRescueApiSchema.execute(mutation).as_json

      expect(user.gear.length).to eq(0)
    end
  end
end
