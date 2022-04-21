class Comment < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :event

  validates_presence_of :body, :event_id, :guest_id

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  private

  def notify_recipient
    CommentNotification.with(comment: self, event: event).deliver_later(event.host)
  end

  def cleanup_notifications
    notifications_as_comment.destroy_all
  end

end
