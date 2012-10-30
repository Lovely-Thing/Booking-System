class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :confirmed
  has_secure_password

  before_create :create_confirmation_code

  before_save { |user| user.email = email.downcase }  
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  	uniqueness: { case_sensitive: false }

  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # since we are using Single Table Inheritance for our Users, Clients, and Stylists
  # we need to do the following so that child classes will be understood as
  # having a User model.
  # See Alex Reisner's blog post here:
  #   http://code.alexreisner.com/articles/single-table-inheritance-in-rails.html
  def self.inherited(child)
    child.instance_eval do
      def model_name
        User.model_name
      end
    end
    super
  end 

  private

	def create_remember_token
		self.remember_token = SecureRandom.urlsafe_base64
	end

  def create_confirmation_code
    self.confirmation_code = SecureRandom.hex(10)
  end

end
