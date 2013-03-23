class WirelessProvider < ActiveRecord::Base
  attr_accessible :description, :domain
  has_one :user
end
