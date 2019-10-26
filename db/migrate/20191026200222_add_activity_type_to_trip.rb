class AddActivityTypeToTrip < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :activity_type, :string
  end
end
