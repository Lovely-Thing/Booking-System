class Appointment < ActiveRecord::Base
	belongs_to :employee

	# client
	belongs_to :client, :foreign_key => "customer_id"

	has_one :salon, through: :employee

	# has_one :stylist, through: :employee, foreign_key: "employee_id"
	has_one :stylist, through: :employee

  attr_accessible :appointment_time, :customer_id, :employee_id, :stylist_confirmed


  scope :confirmed, where(stylist_confirmed: true)
  scope :pending_confirmation, where(stylist_confirmed: false)
  scope :for_client, lambda { |customer_id| where('customer_id = ? ', customer_id) }
  scope :for_stylist, lambda { |stylist_id| joins(:stylist).where('users.id = ?', stylist_id) }
  scope :future, where("appointment_time > ?", Time.now)
end
