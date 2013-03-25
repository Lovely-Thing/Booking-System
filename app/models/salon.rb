class Salon < ActiveRecord::Base
  has_many :employees
  has_many :stylists, through: :employees, foreign_key: "user_id"
  has_many :services

  attr_accessible :address, :city, :email, :name, :phone, :state, :url, :zip, 
    :sunday_hours, :monday_hours, :tuesday_hours, :wednesday_hours, :thursday_hours, :friday_hours, :saturday_hours,
    :image

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  	uniqueness: { case_sensitive: false }

  validates :name, :address, :city, :state, :zip, :email, presence: true
  validates :name, presence: true, length: { minimum: 4, maximum: 50 }
  validates :zip, presence: true, length: { minimum: 5, maximum: 10 }

  mount_uploader :image, SalonImageUploader
  def salon_admin?(user)
  	stylist = employees.find_by_user_id(user)
  	stylist != nil && stylist.salon_admin
  end

end
