class Mutations::CreateGear < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :item_name, String, required: true
  argument :description, String, required: false

  field :gear, Types::GearType, null: true
  field :errors, [String], null: false

  def resolve(**attributes)
    gear = Gear.new(attributes)
    if gear.save
      {
        gear: gear,
        error: []
      }
    else
      {
        gear: nil,
        errors: gear.errors.full_messages
      }
    end
  end
end
