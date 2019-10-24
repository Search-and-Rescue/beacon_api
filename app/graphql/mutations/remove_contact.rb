class Mutations::RemoveContact < Mutations::BaseMutation
  argument :id, Integer, required: true

  field :emergency_contact, Types::EmergencyContactType, null: true
  field :errors, [String], null: false

  def resolve(id:)
    contact = EmergencyContact.find(id)
    contact.destroy
    {
      contact: contact,
      errors: []
    }
  end
end
