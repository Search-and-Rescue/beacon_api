require 'rails_helper'
WebMock.allow_net_connect!

RSpec.describe Types::QueryType do
  describe 'search and rescue model' do
    it "should return all search and rescue teams" do
      create_pair(:search_and_rescue)
        query = (
          %(query {
            teams {
              id
              teamName
              county
              contact
              contactNumber
              city
              state
            }
          })
        )

       sar = SearchAndRescueApiSchema.execute(query).as_json['data']['teams']
       expect(sar.length).to eq(2)
    end

    it "should return a user" do
      sar = create(:search_and_rescue)
      query = (
        %(query {
          team(id: #{sar.id}) {
            id
            teamName
            county
            contact
            contactNumber
            city
            state
          }
        })
      )
      results = SearchAndRescueApiSchema.execute(query).as_json['data']['team']
      expect(results['id'].to_i).to eq(sar.id)
      expect(results['teamName']).to eq(sar.team_name)
    end
  end
end
