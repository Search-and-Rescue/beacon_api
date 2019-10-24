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
  end
end
