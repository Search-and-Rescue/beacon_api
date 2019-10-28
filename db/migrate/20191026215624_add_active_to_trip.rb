class AddActiveToTrip < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :active, :boolean, :default => true
  end
end
