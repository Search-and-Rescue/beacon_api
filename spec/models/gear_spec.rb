require 'rails_helper'

RSpec.describe Gear, type: :model do
  describe 'Relationships' do
    it { should belong_to :user }
    it { should have_many(:trips).through(:trip_gears) }
  end
end
