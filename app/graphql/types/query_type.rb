module Types
  class QueryType < Types::BaseObject
    # Return all users
    field :users, [Types::UserType], null: false
    def users
      User.all
    end

    # Return single user given ID
    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    # Return single emergency contact given ID
    field :emergency_contact, Types::EmergencyContactType, null: false do
      argument :id, ID, required: true
    end

    def emergency_contact(id:)
      EmergencyContact.find(id)
    end

    field :trips, [Types::TripType], null: true do
      description "Get all Trips"
    end

    field :trip, Types::TripType, null: true do
      description "Find a trip by id"
      argument :id, ID, required: true
    end

    def trip(id:)
      Trip.find(id)
    end

    field :vehicle, Types::VehicleType, null: true do
      description "Find a vehicle by id"
      argument :id, ID, required: true
    end

    def vehicle(id:)
      Vehicle.find(id)
    end

    field :gear, Types::GearType, null: true do
      description "Find a gear by id"
      argument :id, ID, required: true
    end

    def gear(id:)
      Gear.find(id)
    end

    field :teams, [Types::SearchAndRescueType], null: false
    #Gets all search and rescue teams
    def teams
      SearchAndRescue.all
    end

    field :team, Types::SearchAndRescueType, null: true do
      description "Find a team by id"
      argument :id, ID, required: true
    end

    def team(id:)
      SearchAndRescue.find(id)
    end
  end
end
