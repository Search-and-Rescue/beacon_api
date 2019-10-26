class SearchAndRescue < ApplicationRecord
  validates_presence_of :team_name
  validates_presence_of :county
  validates_presence_of :contact
  validates_presence_of :contact_number
  validates_presence_of :state
end
