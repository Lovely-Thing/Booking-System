class Salon < ActiveRecord::Base
  has_many :employees
  has_many :stylists, through: :employees, foreign_key: "user_id"

  attr_accessible :address, :city, :email, :name, :phone, :state, :url, :zip
  validates :name, :address, :city, :state, :zip, :email, presence: true
  validates :name, presence: true, length: { minimum: 4, maximum: 50 }

  def salon_admin?(user)
  	stylist = employees.find_by_user_id(user)
  	stylist != nil && stylist.salon_admin
  end

end
