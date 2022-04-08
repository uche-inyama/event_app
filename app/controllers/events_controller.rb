class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:details, :edit, :update, :show, :destroy]

  def index
    @events = Event.order(created_at: :desc)
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def show
    @comments = @event.comments.limit(4)
    mark_notifications_as_read
  end

  def details
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      respond_to do |format|
        format.html { redirect_to events_path, notice: "An event was successfully created."}
        format.turbo_stream { flash.now[:notice] = "Event was successfully created." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      respond_to do |format|
        format.html { redirect_to events_path, notice: "Event successfully updated." }
        format.turbo_stream { flash.now[:notice] = "Event successfully updated."}
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @events = Event.all
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_path, notice: "An event was successfully deleted."}
      format.turbo_stream { flash.now[:notice] = "Event successfully deleted."}
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