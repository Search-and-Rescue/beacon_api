require 'rails_helper'

RSpec.describe GoogleService do
  before :each do
    places_search = File.open('./spec/fixtures/google_places_search.json')
    stub_request(:get, "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?key=#{ENV['GOOGLE_API_KEY']}&input=Maroon Bells Trailhead&inputtype=textquery&fields=name,geometry").
      to_return(status: 200, body: places_search)
  end

  describe "instance methods" do
    context "#coordinates" do
      it "can get lat/lng coordinates given a location (starting_point)" do
        location = "Maroon Bells Trailhead"
        service = GoogleService.new
        coordinates = service.coordinates(location)[:candidates][0][:geometry][:location]
        expect(coordinates[:lat]).to eq(39.0985569)
        expect(coordinates[:lng]).to eq(-106.9406518)
      end
    end

  end
end
