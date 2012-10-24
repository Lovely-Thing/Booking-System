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
end
