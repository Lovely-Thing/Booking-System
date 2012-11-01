class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_email(params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])

			# sign them in
			sign_in user

			# if their password_reset_request flag is set, redirect them
			# to their profile page with a flash that their password 
			# must be reset
			redirect_to edit_user_path(user), notice: "You must change your password." and return if user.password_reset_required == true

			redirect_back_or user
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
