class StylistServicesController < ApplicationController
  # before_filter :admin_user || current_user.stylist? #, except: :index

  # GET /stylist_services
  # GET /stylist_services.json
  def index
    if params[:employee_id]
      @stylist_services = StylistService.where(employee_id: params[:employee_id])
    else
      if current_user.admin?
        @stylist_services = StylistService.paginate(page: params[:page])
      elsif current_user.stylist?
        @stylist_services = StylistService.paginate(page: params[:page]).where(employee_id: current_user.employees)
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stylist_services, include: [:service] }
    end
  end

  # GET /stylist_services/1
  # GET /stylist_services/1.json
  def show
    @stylist_service = StylistService.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stylist_service }
    end
  end

  # GET /stylist_services/new
  # GET /stylist_services/new.json
  def new
    @stylist_service = StylistService.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stylist_service }
    end
  end

  # GET /stylist_services/1/edit
  def edit
    @stylist_service = StylistService.find(params[:id])
  end

  # POST /stylist_services
  # POST /stylist_services.json
  def create
    @stylist_service = StylistService.new(params[:stylist_service])

    respond_to do |format|
      if @stylist_service.save
        format.html { redirect_to @stylist_service, notice: 'Stylist service was successfully created.' }
        format.json { render json: @stylist_service, status: :created, location: @stylist_service }
      else
        format.html { render action: "new" }
        format.json { render json: @stylist_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stylist_services/1
  # PUT /stylist_services/1.json
  def update
    @stylist_service = StylistService.find(params[:id])

    respond_to do |format|
      params[:stylist_service][:modified] = true
      if @stylist_service.update_attributes(params[:stylist_service])
        format.html { redirect_to @stylist_service, notice: 'Stylist service was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stylist_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stylist_services/1
  # DELETE /stylist_services/1.json
  def destroy
    @stylist_service = StylistService.find(params[:id])
    @stylist_service.destroy

    respond_to do |format|
      format.html { redirect_to stylist_services_url }
      format.json { head :no_content }
    end
  end
end
