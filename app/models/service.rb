class Service < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :salon
  belongs_to :appointment_services

  attr_accessible :description, :duration, :name, :price

end
