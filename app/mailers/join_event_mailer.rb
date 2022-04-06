class JoinEventMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.join_event_mailer.event_joined.subject
  #
  def event_joined(user, event)
    # @greeting = "Hello"
    @event = event
    @user = user

    mail to: user.email,
    subject: "New event participant"
  end
end
