require 'rails_helper'

RSpec.describe TripGear, type: :model do
  describe 'Relationships' do
    it { should belong_to :trip }
    it { should belong_to :gear }
  end
end
