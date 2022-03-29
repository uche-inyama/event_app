class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.event_id = @event.id
    if @comment.save
      respond_to do |format|
        format.html { redirect_to events_path, notice: "A comment was successfully created."}
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def comment_params
    params.require(:comment).permit(:event_id, :user_id, :body)
  end

  def set_event
    @event = Event.find(params[:event_id])
  end
end