require 'rails_helper'

RSpec.describe EmergencyContact, type: :model do
  describe 'Relationships' do
    it { should belong_to :user }
    it { should have_many(:trips).through(:trip_contacts) }
  end

  describe 'Validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :phone}
    it { should validate_presence_of :email}
  end
end
