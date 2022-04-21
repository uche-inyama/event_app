# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class CommentNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  # 
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    @event = Event.find(params[:comment][:event_id])
    @comment = Comment.find(params[:comment][:id])
    @user = User.find(@comment.guest_id)
    "#{@user.email} commented on your event: #{@event.theme.truncate(10)}"
  end
  #
  def url
    event_path(Event.find(params[:comment][:event_id]))
  end
end
