class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :starting_point
      t.string :ending_point
      t.date :start_date
      t.datetime :start_time
      t.date :end_date
      t.datetime :end_time
      t.date :notification_date
      t.datetime :notification_time
      t.integer :traveling_companions
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
