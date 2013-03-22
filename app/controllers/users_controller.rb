
class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:index, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end



	def create 

    # if we got here from the Salon maintenance page, (a salon
    # manager added a user), add the user to the salon and
    # redirect back to the salon
    if params[:salon_id]

      @salon = Salon.find(params[:salon_id])

      # check to see if this user already exists.
      @user = User.find_by_email(params[:user][:email])

      new_user = false
      if @user
        if @user.class != "Stylist" 
          @user.update_attribute(:type, "Stylist")
          @user = User.find_by_email(params[:user][:email])
        end
        @salon.stylists << @user
      else
        new_user = true
        @user = @salon.stylists.build(params[:user])

        # TODO: do something a little more creative here on the password
        #       and send it to the user in an email.
        @user.password = 'password'
        @user.password_confirmation = 'password'
        @user.password_reset_required = true
      end
      if @salon.save

        if new_user == true
          UserNotifier.add_new_to_salon(@user, @salon).deliver
        else
          UserNotifier.add_to_salon(@user, @salon).deliver
        end

        redirect_to @salon
        return
      end
    end

    # otherwise... we got here from the signup page. 
    # so, we probably aren't doing this right!
    @user = User.new(params[:user])
    @user.type = "Client"

		if @user.save
			sign_in @user

      # send them a signup email
      UserNotifier.signedup(@user).deliver

			# everything is good. handle the success scenario
			flash[:success] = "Thanks for signing up for Madrilla! Please confirm your email by clicking on the link we just sent to you."
			redirect_to @user
		else
			render 'new'
		end
	end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_url
  end

	def show 
		@user = User.find(params[:id])
	end
	
  def new
  	@user = User.new
  end


  def edit
  end


  def update
  	if @user.update_attributes(params[:user])
  		flash[:success] = "Profile updated"
  		sign_in @user
  		redirect_to @user
  	else
  		render 'edit'
  	end
  end


  def confirm
    @user = User.find(params[:id])
    if @user && @user.confirmation_code == params[:confirmation_code]
      @user.update_attribute(:confirmed, true)
      sign_in @user
      render 'confirm'
    else
      flash[:error] = "We're sorry. That confirmation link was invalid."
      redirect_to root_path
    end
  end

  def forgot_password
  end


  def password_reset
    @user = User.find_by_email(params[:email])

    if @user
      @user.update_attribute(:reset_code, SecureRandom.hex(10))
      UserNotifier.password_reset(@user).deliver
    else
      # go to the "who the crap are you?" page

    end
    @user
  end

  def recover
    
    @reset_code = params[:reset_code]

    if params[:email] 
      @user = User.find_by_email(params[:email])
      if @user.reset_code == params[:reset_code]
        if @user.update_attributes(:password => params[:password], 
            :password_confirmation => params[:password_confirmation],
            :reset_code => '')
          # you're good
          redirect_to root_path, notice: "Your password has been successfully reset."
        else
          redirect_to recover_path(params[:reset_code])
        end
      end
    end

  end

  private

  	def signed_in_user
      unless signed_in?
        store_location
  		  redirect_to signin_url, notice: "Please sign in."
      end
  	end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) 
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
