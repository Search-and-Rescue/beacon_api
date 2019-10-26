class CreateSearchAndRescues < ActiveRecord::Migration[5.2]
  def change
    create_table :search_and_rescues do |t|
      t.string :team_name
      t.string :county
      t.string :contact
      t.string :contact_number
      t.string :city
      t.string :state

      t.timestamps
    end
  end
end
