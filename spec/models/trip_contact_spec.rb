require 'rails_helper'

RSpec.describe TripContact, type: :model do
  describe 'Relationships' do
    it { should belong_to :trip }
    it { should belong_to :emergency_contact }
  end
end
