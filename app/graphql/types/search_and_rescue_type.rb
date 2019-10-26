module Types
  class SearchAndRescueType < Types::BaseObject
    field :id, ID, null: false
    field :team_name, String, null: false
    field :county, String, null: false
    field :contact, String, null: false
    field :contact_number, String, null: false
    field :city, String, null: true
    field :state, String, null: false
  end
end
