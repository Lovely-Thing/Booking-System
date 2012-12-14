class UserNotifier < ActionMailer::Base
  default from: "postmaster@madrilla.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_notifier.signedup.subject
  #
  def signedup(user)
    @user = user
    
    mail to: user.email, subject: 'Thanks for signing up with Madrilla!'
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
    mail to: @stylist.email, subject: "#{@client.name} requested an appointment with you"
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
    mail to: @stylist.email, subject: "Your Updated Appointment isConfirmed"
  end

  def appointment_canceled(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @stylist = appointment.stylist
    @client = appointment.client
    mail to: @client.email, cc: @stylist.email, subject: "Appointment Canceled"
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
    mail to: @stylist.email, subject: "Appointment Rescheduled by Client"
  end

  def stylist_reschedule(appointment)
    @appointment = appointment
    @salon = appointment.salon
    @stylist = appointment.stylist
    @client = appointment.client
    mail to: @client.email, subject: "Your Appointment Was Rescheduled"
  end

end
