require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Relationships' do
    it { should have_many :trips }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_length_of(:state) }
    it { should validate_presence_of(:zip) }
  end

  describe User do
    describe 'experience_level' do
      it "can have a moderate experience level" do
        user = User.create(name: "Bear", email: "bear@gmail.com", city: "Woods", state: "CO", zip: 80220, experience_level: 1)

        expect(user.experience_level).to eq('moderate')
      end
    end
  end
end
