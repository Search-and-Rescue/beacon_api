require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'Relationships' do
    it { should belong_to :user }
    it { should have_many(:emergency_contacts).through(:trip_contacts) }
  end

  describe 'Validations' do
    it { should validate_presence_of :name}
  end
end
