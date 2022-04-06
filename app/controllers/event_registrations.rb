class EventRegistrations < ApplicationController
  before_action :authenticate_user!

  def create
    @credentials = current_user.event_registrations.build(registration_params)
    if @crendentials.save
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Thanks for joining. A confirmation link has been sent  to #{current_user.email}" }
      end
    end
  end

  def destroy
  end

  private

  def registration_params
    params.require(:event_registration).permit(:user_id, :event_id)
  end
end