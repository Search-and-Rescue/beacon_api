module Types
  class TripType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :activity_type, String, null: false
    field :starting_point, String, null: false
    field :ending_point, String, null: false
    field :start_date, String, null: true
    field :start_time, String, null: true
    field :end_date, String, null: true
    field :end_time, String, null: true
    field :notification_date, String, null: true
    field :notification_time, String, null: true
    field :traveling_companions, Integer, null: true
    field :active, Boolean, null: false

    field :user, Types::UserType, null: false
    field :trip_gears, [Types::TripGearType], null: true
    field :gears, [Types::GearType], null: true
    field :emergency_contacts, [Types::EmergencyContactType], null: true
    field :nearby_sar_teams, [Types::SearchAndRescueType], null: true

    def nearby_sar_teams
      coordinates = GoogleSearchFacade.new(object.starting_point).coordinates
      lat = coordinates[:lat]
      lng = coordinates[:lng]
      SearchAndRescue.near([lat, lng], 100)
    end
  end
end
