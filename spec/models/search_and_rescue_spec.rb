require 'rails_helper'

RSpec.describe SearchAndRescue, type: :model do
  before :each do
    open_street_map = File.open('./spec/fixtures/open_street_map.json')
    stub_request(:get, "https://nominatim.openstreetmap.org/search?accept-language=en&addressdetails=1&format=json&q=,%20US").
      to_return(status: 200, body: open_street_map)
    open_street_map_2 = File.open('./spec/fixtures/open_street_map_2.json')
    stub_request(:get, "https://nominatim.openstreetmap.org/search?accept-language=en&addressdetails=1&format=json&q=US").
      to_return(status: 200, body: open_street_map_2)
  end

  describe 'Validations' do
    it { should validate_presence_of :team_name}
    it { should validate_presence_of :county}
    it { should validate_presence_of :contact}
    it { should validate_presence_of :contact_number}
    it { should validate_presence_of :state}
  end
end
