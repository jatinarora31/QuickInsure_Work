class CreateStudents < ActiveRecord::Migration[8.1]
  def change
    create_table :students do |t|
      t.integer :admission_no
      t.integer :rollno
      t.string :name
      t.integer :standard
      t.date :dob
      t.references :mark, null: false, foreign_key: true

      t.timestamps
    end
  end
end
