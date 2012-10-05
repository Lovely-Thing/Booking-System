class SalonStylist < ActiveRecord::Base
  belongs_to :user
  belongs_to :salon

  attr_accessible :salon_id, :user_id
  
end
