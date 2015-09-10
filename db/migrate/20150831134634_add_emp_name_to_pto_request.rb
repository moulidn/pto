class AddEmpNameToPtoRequest < ActiveRecord::Migration
  def change
    add_column :pto_requests, :Emp_Name, :string
  end
end
