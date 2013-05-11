class StylistService < ActiveRecord::Base
  attr_accessible :duration, :employee_id, :modified, :price, :service_id

  belongs_to :employee
  belongs_to :service

end
