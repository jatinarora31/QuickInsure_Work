class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :isbn
      t.integer :edition
      t.references :category, null: false, foreign_key: true
      t.references :publisher, null: false, foreign_key: true
      t.integer :total_copies
      t.integer :available_copies

      t.timestamps
    end
  end
end
