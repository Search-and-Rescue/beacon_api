module Types
  class MutationType < Types::BaseObject
    field :removeGearFromTrip, mutation: Mutations::RemoveGearFromTrip
    field :addGearToTrip, mutation: Mutations::AddGearToTrip
    field :removeContactFromTrip, mutation: Mutations::RemoveContactFromTrip
    field :addContactToTrip, mutation: Mutations::AddContactToTrip
    field :removeContact, mutation: Mutations::RemoveContact
    field :createContact, mutation: Mutations::CreateContact
    field :updateContact, mutation: Mutations::UpdateContact
    field :createUser, mutation: Mutations::CreateUser
    field :updateUser, mutation: Mutations::UpdateUser
    field :createTrip, mutation: Mutations::CreateTrip
    field :updateTrip, mutation: Mutations::UpdateTrip
    field :createVehicle, mutation: Mutations::CreateVehicle
    field :updateVehicle, mutation: Mutations::UpdateVehicle
    field :removeVehicle, mutation: Mutations::RemoveVehicle
    field :createGear, mutation: Mutations::CreateGear
    field :updateGear, mutation: Mutations::UpdateGear
    field :removeGear, mutation: Mutations::RemoveGear
  end
end
