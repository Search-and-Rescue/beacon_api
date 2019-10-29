class AddCoordinatesToSarTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :search_and_rescues, :latitude, :float
    add_column :search_and_rescues, :longitude, :float
  end
end
