class Mutations::RemoveGear < Mutations::BaseMutation
  argument :id, ID, required: true

  field :gear, Types::GearType, null: true
  field :errors, [String], null: false

  def resolve(**attributes)
    gear = Gear.find(attributes[:id])
    gear.destroy
      {
        gear: gear,
        error: []
      }
  end
end
