class CreateTodos < ActiveRecord::Migration[8.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.text :description
      t.boolean :is_completed, default: false

      t.timestamps
    end
  end
end
