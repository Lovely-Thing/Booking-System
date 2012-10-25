class UserNotifier < ActionMailer::Base
  default from: "from@example.com"

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
  
end
