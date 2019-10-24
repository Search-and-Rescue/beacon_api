require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe 'Relationships' do
    it { should belong_to :user }
  end
end
