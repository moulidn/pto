class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :emp_no
      t.string :emp_name
      t.string :emp_email

      t.timestamps
    end
  end
end
