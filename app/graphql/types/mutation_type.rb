module Types
  class MutationType < Types::BaseObject
    field :removeContact, mutation: Mutations::RemoveContact
    field :createContact, mutation: Mutations::CreateContact
    field :updateContact, mutation: Mutations::UpdateContact
    field :createUser, mutation: Mutations::CreateUser
    field :updateUser, mutation: Mutations::UpdateUser
    field :createTrip, mutation: Mutations::CreateTrip
    field :updateTrip, mutation: Mutations::UpdateTrip
    field :createVehicle, mutation: Mutations::CreateVehicle
    field :updateVehicle, mutation: Mutations::UpdateVehicle
    field :deleteVehicle, mutation: Mutations::DeleteVehicle
  end
end
