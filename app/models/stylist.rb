class Stylist < User
	has_many :employees, foreign_key: :user_id, dependent: :destroy # places of employment
  has_many :salons, through: :employees, foreign_key: :user_id
  has_many :appointments, through: :employees, dependent: :destroy

end
