class Mutations::SignInUser < Mutations::BaseMutation
  null true

  argument :email, String, required: false
  argument :password, String, required: false

  field :token, String, null: true
  field :user, Types::UserType, null: true

  def resolve(email: nil, password: nil)
    user = User.find_by(email: email)

    return {error: "Email or password is incorrect" } unless user
    return {error: "Email or password is incorrect" } unless user.authenticate(password)

    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
    token = crypt.encrypt_and_sign("user-id:#{ user.id }")

    context[:session][:token] = token
    { user: user, token: token }
  end
end
