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
  end
end
