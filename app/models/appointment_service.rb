class AppointmentService < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :service
  belongs_to :salon

  attr_accessible :appointment_id, :service_id
end
