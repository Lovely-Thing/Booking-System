class Stylist < User
	has_many :employees, foreign_key: :user_id, dependent: :destroy # places of employment
  has_many :salons, through: :employees, foreign_key: :user_id
  has_many :appointments, through: :employees, dependent: :destroy

  def clients
  	client_list = []
  	self.employees.each do |employee| 
  		client_list.concat employee.clients
  	end
  	client_list
  end
end
