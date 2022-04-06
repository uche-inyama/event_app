class JoinEventMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.join_event_mailer.event_joined.subject
  #
  def event_joined
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
