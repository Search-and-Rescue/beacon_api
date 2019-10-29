class SearchAndRescue < ApplicationRecord
  validates_presence_of :team_name
  validates_presence_of :county
  validates_presence_of :contact
  validates_presence_of :contact_number
  validates_presence_of :city
  validates_presence_of :state

  geocoded_by :address
  after_validation :geocode

  def address
    [city, state, 'US'].compact.join(', ')
  end
end
