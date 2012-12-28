class Service < ActiveRecord::Base
  attr_accessible :description, :duration, :name, :price
end
