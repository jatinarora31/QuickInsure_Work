class CreateAuthors < ActiveRecord::Migration[8.1]
  def change
    create_table :authors do |t|
      t.string :author_name
      t.string :nationality
      t.integer :birth_year

      t.timestamps
    end
  end
end
