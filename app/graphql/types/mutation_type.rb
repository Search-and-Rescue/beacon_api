module Types
  class MutationType < Types::BaseObject
    field :createContact, mutation: Mutations::CreateContact
    field :updateContact, mutation: Mutations::UpdateContact
    field :createUser, mutation: Mutations::CreateUser
    field :updateUser, mutation: Mutations::UpdateUser
  end
end
