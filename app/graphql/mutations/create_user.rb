class Mutations::CreateUser < Mutations::BaseMutation
  argument :name, String, required: true
  argument :email, String, required: true
  argument :address, String, required: false
  argument :city, String, required: false
  argument :state, String, required: false
  argument :zip, Integer, required: false
  argument :phone, String, required: false
  argument :password_digest, String, required: false
  argument :allergies, String, required: false
  argument :birth_date, String, required: false
  argument :weight, Integer, required: false
  argument :height, String, required: false
  argument :hair_color, String, required: false
  argument :skin_color, String, required: false
  argument :gender, String, required: false
  argument :cosar_card, Boolean, required: false
  argument :experience_level, Integer, required: false

  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(**attributes)
    user = User.new(attributes)
    if user.save
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
