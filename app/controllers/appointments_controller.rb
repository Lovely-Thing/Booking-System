
class AppointmentsController < ApplicationController
  before_filter :associated_user, only: [:edit, :show, :update, :destroy]

  # GET /appointments
  # GET /appointments.json
  def index
    if current_user.stylist?
      @appointments = Appointment.for_stylist(current_user).order("appointment_time").future.not_canceled
    else
      @appointments = Appointment.for_client(current_user).order("appointment_time").future.not_canceled
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @appointments }
    end
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @appointment }
    end
  end

  # GET /appointments/new
  # GET /appointments/new.json
  def new
    @appointment = Appointment.new
    @appointment.customer_id = current_user.id
    @appointment.employee_id  = params[:employee_id]
    employee = Employee.find(params[:employee_id])
    @stylist = employee.stylist

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @appointment }
    end
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(params[:appointment])

    respond_to do |format|
      if @appointment.save

        # send notifications to client and stylist
        UserNotifier.client_new_appointment(@appointment).deliver
        UserNotifier.stylist_new_appointment(@appointment).deliver

        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render json: @appointment, status: :created, location: @appointment }
      else
        format.html { render action: "new" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /appointments/1
  # PUT /appointments/1.json
  def update
 
    respond_to do |format|

      if @appointment.update_attributes(params[:appointment])

        if current_user == @appointment.client 
          logger.debug("Debug: the current user is the client")
          @appointment.client_reschedule
          UserNotifier.client_reschedule(@appointment).deliver
        else
          logger.debug("Debug: the current user is the stylist")
          @appointment.stylist_reschedule
          UserNotifier.stylist_reschedule(@appointment).deliver
        end


        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointments_url }
      format.json { head :no_content }
    end
  end


  # Confirm
  def confirm
    @appointment = Appointment.find(params[:id])
    respond_to do |format|

      all_good = false

      if @appointment.pending_client_approval?

        if @appointment.client_approve!
          # send stylist email indicating the stylist confirmed the appointment
          UserNotifier.client_confirmed(@appointment).deliver
          all_good = true
        end

      else
        if @appointment.stylist_approve!
          # send client email indicating the stylist confirmed the appointment
          UserNotifier.appointment_confirmed(@appointment).deliver
          all_good = true
        end
      end

      if all_good
        format.html { redirect_to action: "index", notice: 'Appointment confirmed!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # Cancel
  def cancel
    @appointment = Appointment.find(params[:id])
    respond_to do |format|
      if @appointment.cancel!

        # send client email indicating the stylist confirmed the appointment
        UserNotifier.appointment_canceled(@appointment).deliver

        format.html { redirect_to action: "index", notice: 'Appointment canceled!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def associated_user
      @appointment = Appointment.find(params[:id])

      # make sure the current user is either the stylist, client, or admin
      if @appointment.stylist != current_user
        logger.debug "Debug: You are not the stylist"
        if @appointment.client != current_user
          logger.debug "Debug: You are not the client"
          if !@appointment.salon.salon_admin?(current_user)
            logger.debug "Debug: You are not the salon admin"
            redirect_to(root_path)
          end
        end
      end

    end

end
