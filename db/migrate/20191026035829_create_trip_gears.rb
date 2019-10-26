class CreateTripGears < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_gears do |t|
      t.references :trip, foreign_key: true
      t.references :gear, foreign_key: true
      t.string :comments

      t.timestamps
    end
  end
end
