require 'rails_helper'

RSpec.describe Types::QueryType do
  before :each do
    # WebMock.allow_net_connect!
    places_search = File.open('./spec/fixtures/google_places_search.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?key=#{ENV['GOOGLE_API_KEY']}&input=Maroon Bells Trailhead&inputtype=textquery&fields=name,geometry").
      to_return(status: 200, body: places_search)
    poncha = File.open('./spec/fixtures/poncha_springs.json')
    stub_request(:get, "https://nominatim.openstreetmap.org/search?accept-language=en&addressdetails=1&format=json&q=Poncha%20Springs,%20CO,%20US").
      to_return(status: 200, body: poncha)
    castle_rock = File.open('./spec/fixtures/castle_rock.json')
    stub_request(:get, "https://nominatim.openstreetmap.org/search?accept-language=en&addressdetails=1&format=json&q=Castle%20Rock,%20CO,%20US").
      to_return(status: 200, body: castle_rock)
  end

  it "should return nearby SAR teams to a trips starting point" do
    trip = create(:trip, name: "Maroon Bells", starting_point: "Maroon Bells Trailhead")
    team_1 = SearchAndRescue.create(
      team_name: "Chaffee County Sheriff's Patrol",
      county: "Chaffee",
      contact: "Sherrif's Office",
      contact_number: "719-539-2596",
      city: "Poncha Springs",
      state: "CO"
    )
    team_2 = SearchAndRescue.create(
      team_name: "Douglas County SAR",
      county: "Douglas",
      contact: "Sherrif's Office",
      contact_number: "303-660-7500",
      city: "Castle Rock",
      state: "CO"
    )
    query = (
      %(query {
        trip(id: #{trip.id}) {
          name
          nearbySarTeams{
            id
            teamName
          }
        }
      })
    )
    results = SearchAndRescueApiSchema.execute(query).as_json['data']['trip']['nearbySarTeams']
    expect(results[0]['teamName']).to eq(team_1.team_name)
  end

end
