module Mutations
  class UpdateUser < GraphQL::Schema::RelayClassicMutation
    field :user, Types::UserType, null: false

    argument :id, ID, required: true

    def resolve(id:)
      binding.pry
    end
  end
end
