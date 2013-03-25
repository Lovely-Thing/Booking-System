class UserNotifier < ActionMailer::Base
  default from: "postmaster@madrilla.com" #, bcc: 'andrunix@gmail.com'
  # default from: "postmaster@madrilla.com", bcc: 'andrunix@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifier.signedup.subject
  #
  def signedup(user)
    @user = user
    
    mail to: user.email, bcc: 'andrunix@gmail.com', subject: 'Thanks for signing up with Madrilla!'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifier.confirmed.subject
  #
  def confirmed
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  def contact(name, email, message)
    @name = name
    @email = email
    @message = message
    mail to: "andrunix@gmail.com", subject: "Comments from users"
  end


  def add_to_salon(user, salon)
    @user = user
    @salon = salon
    mail to: user.email, subject: "You've been added as a stylist"
  end

  def add_new_to_salon(user, salon)
    @user = user
    @salon = salon
    mail to: user.email, subject: "#{salon.name} Added You to Madrilla.com"
  end
  

  # When a new appointment is created, this mailer is used
  def stylist_new_appointment(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @client = appointment.client
    @stylist = appointment.stylist

    mail to: [@stylist.email, @stylist.phone_for_sms], 
      subject: "New Appointment with #{@client.name}"
  end

  # When a new appointment is created, this mailer is used
  def client_new_appointment(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @client = appointment.client
    @stylist = appointment.stylist
    mail to: @client.email, subject: "Appointment with #{@stylist.name} Requested"
  end

  # when a stylist confirms an appointment
  def appointment_confirmed(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @stylist = appointment.stylist
    @client = appointment.client
    mail to: @client.email, subject: "Your Appointment Has Been Confirmed"
  end

  def client_confirmed(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @stylist = appointment.stylist
    @client = appointment.client

    if @stylist.phone_for_sms.nil?
      mail to: @stylist.email, 
        subject: "#{@client.name} Confirmed Your Updated Appointment"
    else
      mail to: @stylist.email, 
        cc: @stylist.phone_for_sms, 
        subject: "#{@client.name} Confirmed Your Updated Appointment"    
    end
  end

  def appointment_canceled(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @stylist = appointment.stylist
    @client = appointment.client

    bcc = [@client.phone_for_sms, @stylist.phone_for_sms].join(',')
    if @client.phone_for_sms.nil?
      mail to: @client.email, cc: @stylist.email, subject: "Appointment Canceled"
    else
      mail to: @client.email, cc: @stylist.email, bcc: bcc, subject: "Appointment Canceled"
    end
  end

  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "Password Reset Request"
  end

  def client_reschedule(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @stylist = appointment.stylist
    @client = appointment.client

    if @stylist.phone_for_sms.nil?
      mail to: @stylist.email, 
        subject: "Appointment Rescheduled by #{@client.name}"
    else
      mail to: @stylist.email, 
        cc: @stylist.phone_for_sms, 
        subject: "Appointment Rescheduled by #{@client.name}"
    end
  end

  def stylist_reschedule(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @stylist = appointment.stylist
    @client = appointment.client


    if @client.phone_for_sms.nil?
      mail to: @client.email, 
        subject: "Appointment Rescheduled by #{@stylist.name}"
    else
      mail to: @client.email, 
        cc: @client.phone_for_sms, 
        subject: "Appointment Rescheduled by #{@stylist.name}"
    end
  end

end
