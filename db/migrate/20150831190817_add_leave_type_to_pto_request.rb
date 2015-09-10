class AddLeaveTypeToPtoRequest < ActiveRecord::Migration
  def change
    add_column :pto_requests, :leave_type, :string
    add_column :pto_requests, :leave_duration, :string
  end
end
