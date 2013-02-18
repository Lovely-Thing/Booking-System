
class AppointmentsController < ApplicationController
  before_filter :associated_user, only: [:edit, :show, :update, :destroy]
  # before_filter :format_date, only: [:create, :update]
  
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
    @appointment.employee_id  = session[:employee_id]
    employee = Employee.find(session[:employee_id])
    @stylist = employee.stylist

    # insert all of the requested services into the new appointment
    #svcs = params[:service]
    session[:service] = params[:service]
    params[:service].each do |id| 
      logger.debug("Service id: #{id}" )
      @appointment.services << Service.find(id)
    end

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

    svcs = session[:service]
    svcs.each do |service|
      @appointment.services << Service.find(service)
    end

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

      logger.debug("DEBUG: date is: #{params[:appointment][:appointment_time]}")

      # add the history record
      hist = @appointment.appointment_history.build(appointment_id: @appointment.id,
        customer_id: @appointment.customer_id,
        employee_id: @appointment.employee_id,
        appointment_time: @appointment.appointment_time,
        state: @appointment.state, 
        note: @appointment.note)

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
        format.html { redirect_to current_user, notice: 'Appointment confirmed!' }
        # format.html { redirect_to action: "index", notice: 'Appointment confirmed!' }
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
        # logger.debug "Debug: You are not the stylist"
        if @appointment.client != current_user
          # logger.debug "Debug: You are not the client"
          if !@appointment.salon.salon_admin?(current_user)
            #logger.debug "Debug: You are not the salon admin"
            redirect_to(root_path)
          end
        end
      end

    end


    def format_date
      # The datepicker is awesome but it doesn't format the date the way Ruby
      # wants it so we parse it out and shove it back in the params hash.
      
      # logger.debug("DEBUG: the appointment time is: #{params[:appointment][:appointment_time]}")
      apt = params[:appointment][:appointment_time]
      params[:appointment][:appointment_time] = DateTime.strptime(apt, "%m/%d/%Y %I:%M %p") unless apt == ''
    end

end
