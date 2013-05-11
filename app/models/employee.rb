class Employee < ActiveRecord::Base
	belongs_to :stylist, foreign_key: "user_id"
	belongs_to :salon
	has_many :appointments
	has_many :stylist_services

  attr_accessible :salon_admin, :salon_id, :user_id
end
