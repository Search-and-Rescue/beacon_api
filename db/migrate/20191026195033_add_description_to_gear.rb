class AddDescriptionToGear < ActiveRecord::Migration[5.2]
  def change
    add_column :gears, :description, :string
  end
end
