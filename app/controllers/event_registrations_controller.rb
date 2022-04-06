class EventRegistrationsController < ApplicationController
  before_action :authenticate_user!

  def create
    @event_registration = current_user.event_registrations.build(registration_params)
    if @event_registration.save
      JoinEventMailer.event_joined(User.last, Event.last).deliver_now
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Thanks for joining. A confirmation link has been sent  to #{current_user.email}" }
      end
    end
  end

  def destroy
  end

  private

  def registration_params
    params.permit(:event_id)
  end

end