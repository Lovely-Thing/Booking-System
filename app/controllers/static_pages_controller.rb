
class StaticPagesController < ApplicationController
  def home
  	# if the user is signed in, don't let them go back to the signup/signin screen
  	redirect_to current_user if signed_in?
  end

  def help
  end

  def about
  end

  def contact
  end
  
end
