class Mutations::DeleteVehicle < Mutations::BaseMutation
  argument :id, ID, required: true

  field :vehicle, Types::VehicleType, null: true
  field :errors, [String], null: false

  def resolve(**attributes)
    vehicle = Vehicle.find(attributes[:id])
    vehicle.destroy
      {
        vehicle: vehicle,
        error: []
      }
  end
end
