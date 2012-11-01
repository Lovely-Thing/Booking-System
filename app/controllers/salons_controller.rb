
class SalonsController < ApplicationController

	def index
	    @salons = Salon.paginate(page: params[:page])
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
		# @stylist = @salon.stylists.build
		@employee = @salon.stylists.build

		respond_to do |format|
			format.html
			format.json { render json: @salon }
		end
	end

	def edit
		@salon = Salon.find(params[:id])
	end



  def update
  	@salon = Salon.find(params[:id])
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
  	respond_to do |format|
  		format.html
  		format.json { render json: @salon }
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

end
