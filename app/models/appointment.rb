class Appointment < ActiveRecord::Base
	belongs_to :employee
	belongs_to :client, :foreign_key => "customer_id"
	has_one :salon, through: :employee
	has_one :stylist, through: :employee

  attr_accessible :appointment_time, :customer_id, :employee_id

  # validate :valid_appointment_time

  #----------------
  # using the state_machine gem here to control the approval, rescheduling,
  # confirming, and cancelling of appointments
  States = {
  	pending_stylist_approval: 0,
  	pending_client_approval: 1,
  	confirmed: 2,
  	canceled: 3
  }

  state_machine :state, :initial => :pending_stylist_approval do
  	# Create states based on our States constant
  	# I think we only need to do this because we were not 
  	# storing the state as a string 
  	States.each do |name, value|
  		state name, value: value
  	end

  	event :stylist_approve do
  		transition :pending_stylist_approval => :confirmed
  	end

  	event :client_reschedule do
  		transition [:confirmed, :pending_stylist_approval] => :pending_stylist_approval
  	end

  	event :stylist_reschedule do
  		transition [:confirmed, :pending_client_approval, :pending_stylist_approval] => :pending_client_approval
  	end

  	event :client_approve do
  		transition :pending_client_approval => :confirmed
  	end

  	event :cancel do
  		transition [:pending_stylist_approval, :pending_client_approval, :confirmed] => :canceled
  	end
  end

  def status
  	retval = ''
  	if pending_stylist_approval? 
  		retval = 'Pending Stylist Approval'
  	elsif pending_client_approval?
  		retval = 'Pending Client Approval'
  	elsif confirmed?
  		retval = 'Confirmed'
  	elsif canceled?
  		retval = 'Canceled'
  	end
  	retval
  end

  scope :not_canceled, where('state != ?', Appointment::States[:canceled])
  scope :for_client, lambda { |customer_id| where('customer_id = ? ', customer_id) }
  scope :for_stylist, lambda { |stylist_id| joins(:stylist).where('users.id = ?', stylist_id) }
  scope :future, where("appointment_time > ?", Time.now)

  # def valid_appointment_time
  #   logger.debug("DEBUG: #{appointment_time}, #{1.hour.from_now}")

  #   errors.add(:appointment_time, 'must be at least one hour in the future.') unless appointment_time >= Date.today
  # end

end
