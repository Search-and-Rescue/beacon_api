class Mutations::UpdateContact < Mutations::BaseMutation
  argument :id, Integer, required: true
  argument :user_id, Integer, required: false
  argument :name, String, required: false
  argument :email, String, required: false
  argument :phone, String, required: false

  field :emergencyContact, Types::EmergencyContactType, null: false
  field :errors, [String], null: false

  def resolve(**attributes)
    contact = EmergencyContact.find(attributes[:id])
    if contact.update!(attributes)
      {
        contact: contact,
        errors: []
      }
    else
      {
        contact: nil,
        errors: contact.errors.full_messages
      }
    end
  end
end
