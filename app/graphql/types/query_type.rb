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

    field :trips, [Types::TripType], null: true do
      description "Get all Trips"
    end

    field :trip, Types::TripType, null: true do
      description "Find a trip by id"
      argument :id, ID, required: true
    end

    def trips
      Trip.all
    end

    def trip(id:)
      Trip.find(id)
    end
  end
end
