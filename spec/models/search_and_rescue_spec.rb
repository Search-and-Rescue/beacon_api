require 'rails_helper'
WebMock.allow_net_connect!

RSpec.describe SearchAndRescue, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :team_name}
    it { should validate_presence_of :county}
    it { should validate_presence_of :contact}
    it { should validate_presence_of :contact_number}
    it { should validate_presence_of :state}
  end
end
