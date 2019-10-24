class CreateVehicles < ActiveRecord::Migration[5.2]
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.integer :year
      t.string :color
      t.string :license_plate
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
