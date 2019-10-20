class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.integer :zip
      t.string :phone
      t.string :email
      t.string :password_digest
      t.string :allergies
      t.integer :experience_level
      t.integer :age
      t.integer :weight
      t.string :hair_color
      t.string :skin_color
      t.string :gender
      t.boolean :cosar_card

      t.timestamps
    end
  end
end
