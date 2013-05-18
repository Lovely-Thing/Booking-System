class Client < User
	has_many :appointments, foreign_key: "customer_id"
	
end
