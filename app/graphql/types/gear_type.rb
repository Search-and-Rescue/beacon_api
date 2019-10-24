module Types
  class GearType < Types::BaseObject
    field :id, ID, null: false
    field :item_name, String, null: false
    field :user, Types::UserType, null: false
  end
end
