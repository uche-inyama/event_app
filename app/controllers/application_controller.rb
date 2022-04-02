class ApplicationController < ActionController::Base
  before_action :set_notifications, if: :current_user
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar])
  end

  private

  def set_notifications
    notifications = Notification.where(recipient: current_user).newest_first.limit(9)
    @unread = notifications.unread
    @read = notifications.read
  end
end
