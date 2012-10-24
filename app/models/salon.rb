class Salon < ActiveRecord::Base
  has_many :employees
  has_many :users, through: :employees

  attr_accessible :address, :city, :email, :name, :phone, :state, :url, :zip
  validates :name, :address, :city, :state, :zip, :email, presence: true

  validates :name, presence: true, length: { minimum: 4, maximum: 50 }

end
