class Employee < ActiveRecord::Base
	belongs_to :stylist, foreign_key: "user_id"
	belongs_to :salon
	has_many :appointments
	has_many :stylist_services
	# has_many :clients, through: :appointments, foreign_key: "customer_id", uniq: true, order: "name"

  attr_accessible :salon_admin, :salon_id, :user_id


end
