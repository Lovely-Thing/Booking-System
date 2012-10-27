class Appointment < ActiveRecord::Base
	belongs_to :employee

	# client
	belongs_to :client, :foreign_key => "customer_id"

	has_one :salon, through: :employee

	# has_one :stylist, through: :employee, foreign_key: "employee_id"
	has_one :stylist, through: :employee

  attr_accessible :appointment_time, :customer_id, :employee_id, :stylist_confirmed
end
