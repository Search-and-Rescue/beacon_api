class CreateTripContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_contacts do |t|
      t.references :emergency_contact, foreign_key: true
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
