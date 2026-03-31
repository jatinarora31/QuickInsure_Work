class CreateMarks < ActiveRecord::Migration[8.1]
  def change
    create_table :marks do |t|
      t.float :maths
      t.float :physics
      t.float :chemistry
      t.float :english
      t.string :optional

      t.timestamps
    end
  end
end
