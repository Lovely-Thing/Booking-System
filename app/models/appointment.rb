class Appointment < ActiveRecord::Base
	belongs_to :employee
	belongs_to :user, :foreign_key => "customer_id"
  attr_accessible :appointment_time, :customer_id, :employee_id, :stylist_confirmed


end
