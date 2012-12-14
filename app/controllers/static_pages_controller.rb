
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
    if params[:email] && params[:message]
      UserNotifier.contact(params[:name], params[:email], params[:message]).deliver

      redirect_to root_path, notice: "Thank you! Your message has been sent."

    end

  end
  
end
