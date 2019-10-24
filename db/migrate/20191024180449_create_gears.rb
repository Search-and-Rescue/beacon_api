class CreateGears < ActiveRecord::Migration[5.2]
  def change
    create_table :gears do |t|
      t.string :item_name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
