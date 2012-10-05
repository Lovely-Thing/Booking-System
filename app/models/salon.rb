class Salon < ActiveRecord::Base
  has_many :salon_stylists
  has_many :users, through: :salon_stylists

  attr_accessible :address, :city, :email, :name, :phone, :state, :url, :zip
  validates :name, :address, :city, :state, :zip, :email, presence: true

end
