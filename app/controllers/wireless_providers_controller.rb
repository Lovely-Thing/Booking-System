class WirelessProvidersController < ApplicationController
  before_filter :admin_user

  # GET /wireless_providers
  # GET /wireless_providers.json
  def index
    @wireless_providers = WirelessProvider.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wireless_providers }
    end
  end

  # GET /wireless_providers/1
  # GET /wireless_providers/1.json
  def show
    @wireless_provider = WirelessProvider.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wireless_provider }
    end
  end

  # GET /wireless_providers/new
  # GET /wireless_providers/new.json
  def new
    @wireless_provider = WirelessProvider.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wireless_provider }
    end
  end

  # GET /wireless_providers/1/edit
  def edit
    @wireless_provider = WirelessProvider.find(params[:id])
  end

  # POST /wireless_providers
  # POST /wireless_providers.json
  def create
    @wireless_provider = WirelessProvider.new(params[:wireless_provider])

    respond_to do |format|
      if @wireless_provider.save
        format.html { redirect_to @wireless_provider, notice: 'Wireless provider was successfully created.' }
        format.json { render json: @wireless_provider, status: :created, location: @wireless_provider }
      else
        format.html { render action: "new" }
        format.json { render json: @wireless_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wireless_providers/1
  # PUT /wireless_providers/1.json
  def update
    @wireless_provider = WirelessProvider.find(params[:id])

    respond_to do |format|
      if @wireless_provider.update_attributes(params[:wireless_provider])
        format.html { redirect_to @wireless_provider, notice: 'Wireless provider was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wireless_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wireless_providers/1
  # DELETE /wireless_providers/1.json
  def destroy
    @wireless_provider = WirelessProvider.find(params[:id])
    @wireless_provider.destroy

    respond_to do |format|
      format.html { redirect_to wireless_providers_url }
      format.json { head :no_content }
    end
  end


private

    def admin_user
      redirect_to(root_path) unless !current_user.nil? && current_user.admin?
    end


end
