class Event < ApplicationRecord
  include  ImageUploader::Attachment(:image)

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_noticed_notifications model_name: 'Notification'
  has_many :notifications, through: :user, dependent: :destroy
  
  # after_create_commit { broadcast_prepend_to "events" }
  # after_destroy_commit { broadcast_remove_to "events" }
  # after_destroy_commit -> { broadcast_remove_later_to(self, locals: { user: current_user, event: self }) }

  
  validates_presence_of :time, :address, :theme, :details, :event_type, :status

  validates_date :start_date, :on_or_after => lambda { Date.current },
  :on_or_after_message => "must be on or after today's date.",
  :invalid_date_message => "is empty"

  validates_date :end_date, :on_or_after => lambda { Date.current },
  :invalid_date_message => "is empty",
  :on_or_after_message => "must be on or after today's date."

  def get_status(date)
    current_date = DateTime.now.strftime('%Y-%m-%d')
    end_date = date.strftime('%Y-%m-%d')
    end_date < current_date ? 'inactive' : 'active'
  end
end
