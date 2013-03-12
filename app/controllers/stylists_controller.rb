class StylistsController < ApplicationController
  before_filter :get_salon

  def index
    @employees = @salon.employees.all
    @stylists = @salon.stylists.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: [:stylists => @stylists, :employees => @employees], 
        except: [:created_at, :updated_at, :confirmation_code, :confirmed, :password_digest, 
          :password_reset_required, :remember_token, :reset_code, :salon_admin, :salon_id] }
    end
  end

  def create
    @stylist = @salon.stylists.new(params[:stylist])


    respond_to do |format|
      if @stylist.save
        format.html { redirect_to salon_stylist_path(@salon, @stylist), notice: 'Stylist was successfully created.' }
        format.json { render json: salon_stylist_path(@salon, @stylist), status: :created, location: @stylist }
      else
        format.html { render action: "new" }
        format.json { render json: @stylist.errors, status: :unprocessable_entity }
      end
    end    
  end

  def new
    @service = @salon.services.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stylist }
    end
  end

  def edit
    @stylist = @salon.stylists.find(params[:id])
  end

  def show

    @stylist = @salon.stylists.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stylist }
    end

  end

  def update
  end

  def destroy
  end

  private

    def get_salon
      @salon = Salon.find(params[:salon_id])
    end

end
