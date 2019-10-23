module Types
  class EmergencyContactType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :phone, String, null: true
    field :email, String, null: false

    field :user, Types::UserType, null: false
  end
end
