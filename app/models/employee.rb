class Employee < ActiveRecord::Base
  has_many :pto_requests
end
