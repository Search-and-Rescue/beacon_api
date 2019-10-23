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

  end
end
