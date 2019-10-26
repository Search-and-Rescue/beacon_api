require 'rails_helper'

RSpec.describe Types::QueryType do
  describe "gear queries" do
    it "should return all of a user's gear" do
      user = create(:user)
      create_pair(:gear, user_id: user.id)

      query = (
        %(query {
          user(id: #{user.id}) {
            gear {
              itemName
            }
          }
        })
      )

      gear = SearchAndRescueApiSchema.execute(query).as_json['data']['user']['gear']

      expect(gear.length).to eq(2)
    end

    it "should return a single piece of gear" do
      gear_1 = create(:gear)

      query = (
        %(query {
          gear(id: #{gear_1.id}) {
            itemName
            user {
              id
              name
            }
          }
        })
      )
      gear = SearchAndRescueApiSchema.execute(query).as_json['data']['gear']

      expect(gear['itemName']).to eq(gear_1.item_name)
    end
  end
end
