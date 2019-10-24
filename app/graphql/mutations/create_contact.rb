class Mutations::CreateContact < Mutations::BaseMutation
  argument :user_id, Integer, required: true
  argument :name, String, required: true
  argument :email, String, required: true
  argument :phone, String, required: true

  field :emergencyContact, Types::EmergencyContactType, null: false
  field :errors, [String], null: false

  def resolve(**attributes)
    contact = EmergencyContact.new(attributes)
    if contact.save
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
