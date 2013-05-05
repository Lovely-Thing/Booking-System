
class SalonsController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :find_by_name]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: [:edit, :update, :destroy]


	def index
    @salons = Salon.order("name").paginate(page: params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @salons }
    end      
	end

	def new
		@salon = Salon.new
	end
	
	def create 
		@salon = Salon.new(params[:salon])
		if @salon.save
			# everything is good. handle the success scenario
			flash[:success] = "Thanks for signing up your salon with Madrilla!"
			redirect_to @salon
		else
			render 'new'
		end
	end

	def show 
		@salon = Salon.find(params[:id])
    @stylist = Stylist.new

		respond_to do |format|
			format.html
			format.json { render json: @salon }
		end
	end

  def find_by_name
    @salon = Salon.find_by_parameterized_name(params[:salonname])
    @stylist = Stylist.new
    render 'show'
  end


	def edit
		@salon = Salon.find(params[:id])
	end



  def update

  	@salon = Salon.find(params[:id])
    logger.debug "DEBUG: Found the salon, going to update? #{params} "
  	if @salon.update_attributes(params[:salon])
  		flash[:success] = "Salon updated"
  		redirect_to @salon
  	else
  		render 'edit'
  	end
  end

  def destroy
  	Salon.find(params[:id]).destroy
  	flash[:success] = 'Salon deleted'
  	redirect_to salons_url
  end


  def select_stylist
  	@salon = Salon.find(params[:id])
    @stylists = @salon.stylists
  	respond_to do |format|
  		format.html
      format.js 
  		format.json { render json: @salon }
  	end
  end

  def get_stylists
    @salon = Salon.find(params[:id])
    session[:salon_id] = @salon.id
    @employees = @salon.employees
    respond_to do |format|
      format.html
      format.js 
      format.json { render json: @stylists }
    end
  end

  def get_services
    session[:employee_id] = params[:employee_id]
    @salon = Salon.find(session[:salon_id])

    # this is REALLY ugly. Need to fix this.
    @stylist = @salon.employees.find(params[:employee_id]).stylist
    
    respond_to do |format|
      format.html
      format.js
      format.json { render json: @salon.services }
    end
  end

  def toggle_admin
  	logger.debug "toggle_admin got called!"
  	# salon = Salon.find(params[:salon_id])
  	# logger.debug("Debug: we found the salon, #{salon.name}")
  	# emp   = salon.employees.find(params[:id])
  	# logger.debug("Debug:  we found the employee")

  	# emp.update_attribute(salon_admin: !emp.salon_admin)

  	# salon
  end


    # def signed_in_user
    #   unless signed_in?
    #     store_location
    #     redirect_to signin_url, notice: "Please sign in."
    #   end
    # end

    # def correct_user
    #   @user = User.find(params[:id])
    #   redirect_to(root_path) unless current_user?(@user) 
    # end

    # def admin_user
    #   redirect_to(root_path) unless current_user.admin?
    # end


end
