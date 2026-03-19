class CreatePublishers < ActiveRecord::Migration[8.1]
  def change
    create_table :publishers do |t|
      t.string :publisher_name
      t.string :nationality
      t.integer :address

      t.timestamps
    end
  end
end
