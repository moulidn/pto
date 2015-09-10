class PtoRequest < ActiveRecord::Base
  belongs_to :employee
  attr_accessor :from_date,:to_date,:emp_name,:emp_id,:pto_dt
end
