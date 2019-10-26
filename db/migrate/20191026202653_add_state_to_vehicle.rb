class AddStateToVehicle < ActiveRecord::Migration[5.2]
  def change
    add_column :vehicles, :state, :string
  end
end
