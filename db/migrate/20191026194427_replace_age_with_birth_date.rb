class ReplaceAgeWithBirthDate < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :age
    add_column :users, :birth_date, :string
  end
end
