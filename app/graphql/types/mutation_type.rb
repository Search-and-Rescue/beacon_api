module Types
  class MutationType < Types::BaseObject
    field :removeContactFromTrip, mutation: Mutations::RemoveContactFromTrip
    field :addContactToTrip, mutation: Mutations::AddContactToTrip
    field :removeContact, mutation: Mutations::RemoveContact
    field :createContact, mutation: Mutations::CreateContact
    field :updateContact, mutation: Mutations::UpdateContact
    field :createUser, mutation: Mutations::CreateUser
    field :updateUser, mutation: Mutations::UpdateUser
    field :createTrip, mutation: Mutations::CreateTrip
    field :updateTrip, mutation: Mutations::UpdateTrip
  end
end
