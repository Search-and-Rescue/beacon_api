class Mutations::CreateVehicle < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :make, String, required: false
  argument :model, String, required: false
  argument :year, Integer, required: false
  argument :color, String, required: false
  argument :license_plate, String, required: false

  field :vehicle, Types::VehicleType, null: true
  field :errors, [String], null: false

  def resolve(**attributes)
    vehicle = Vehicle.new(attributes)
    if vehicle.save
      {
        vehicle: vehicle,
        error: []
      }
    else
      {
        vehicle: nil,
        errors: vehicle.errors.full_messages
      }
    end
  end
end
