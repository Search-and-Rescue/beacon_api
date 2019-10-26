class Mutations::UpdateGear < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :item_name, String, required: false
  argument :description, String, required: false

  field :gear, Types::GearType, null: true
  field :errors, [String], null: false

  def resolve(**attributes)
    gear = Gear.find(attributes[:id])
    if gear.update!(attributes)
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
