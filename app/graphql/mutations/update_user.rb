class Mutations::UpdateUser < Mutations::BaseMutation
  argument :id, Integer, required: true
  argument :name, String, required: false
  argument :address, String, required: false
  argument :city, String, required: false
  argument :state, String, required: false
  argument :zip, Integer, required: false
  argument :phone, String, required: false
  argument :email, String, required: false
  argument :password_digest, String, required: false
  argument :allergies, String, required: false
  argument :experience_level, Integer, required: false
  argument :age, Integer, required: false
  argument :weight, Integer, required: false
  argument :height, Integer, required: false
  argument :hair_color, String, required: false
  argument :skin_color, String, required: false
  argument :gender, String, required: false
  argument :cosar_card, Boolean, required: false

  field :user, Types::UserType, null: false

  def resolve(**attributes)
    user = User.find(attributes[:id])
    if user.update!(attributes)
      {
        user: user,
        errors: [],
      }
    else
      {
        user: nil,
        errors: user.errors.full_messages
      }
    end
  end
end
