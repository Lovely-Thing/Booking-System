class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  private

  	def current_appointment
  		
  	end
end
