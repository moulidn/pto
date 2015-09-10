class CreatePtoRequests < ActiveRecord::Migration
  def change
    create_table :pto_requests do |t|
      t.string :emp_no
      t.date :pto_date

      t.timestamps
    end
  end
end
