class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:edit, :update, :show, :destroy]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def show
    mark_notifications_as_read
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      respond_to do |format|
        format.html { redirect_to events_path, notice: "An event was successfully created."}
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      redirect_to events_path, notice: "Event successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_path, notice: "An event was successfully destroyed."}
      format.turbo_stream
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event)
      .permit(:start_date, :end_date, :time, :address, :theme, :details, :image, :event_type, :status, :user_id)
  end

  def mark_notifications_as_read
    if current_user
      notifications_to_mark_as_read = @event.notifications_as_event.where(recipient: current_user)
      notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
    end
  end
end