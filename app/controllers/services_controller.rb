
class ServicesController < ApplicationController
  before_filter :admin_user

  # GET /services
  # GET /services.json
  def index
    @salon = Salon.find(params[:salon_id])
    @services = @salon.services

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @services }
    end
  end

  # GET /services/1
  # GET /services/1.json
  def show
    @salon = Salon.find(params[:salon_id])
    @service = @salon.services.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/new
  # GET /services/new.json
  def new
    @salon = Salon.find(params[:salon_id])
    @service = @salon.services.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service }
    end
  end

  # GET /services/1/edit
  def edit
    @salon = Salon.find(params[:salon_id])
    @service = @salon.services.find(params[:id])
  end

  # POST /services
  # POST /services.json
  def create
    @salon = Salon.find(params[:salon_id])
    @service = @salon.services.new(params[:service])

    respond_to do |format|
      if @service.save
        format.html { redirect_to salon_service_path(@salon, @service), notice: 'Service was successfully created.' }
        format.json { render json: salon_service_path(@salon, @service), status: :created, location: @service }
      else
        format.html { render action: "new" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /services/1
  # PUT /services/1.json
  def update
    @salon = Salon.find(params[:salon_id])
    @service = @salon.services.find(params[:id])

    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to salon_service_path(@salon, @service), notice: 'Service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @salon = Salon.find(params[:salon_id])
    @service = @salon.services.find(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to salon_services_url(@salon) }
      format.json { head :no_content }
    end
  end


  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
