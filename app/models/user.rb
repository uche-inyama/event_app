class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # include  ImageUploader::Attachment(:avatar)
  has_one_attached :avatar
    
  has_many :events, foreign_key: :host_id, dependent: :destroy
  has_many :likes, foreign_key: :guest_id, dependent: :destroy
  has_many :comments, foreign_key: :guest_id, dependent: :destroy

  has_many :notifications, as: :recipient, dependent: :destroy

  has_many :event_registrations, foreign_key: :guest_id, dependent: :destroy
  has_many :attended_events, through: :event_registrations, source: :event
  

  def likes?(event)
    event.likes.where(guest_id: id).any?
  end

  private

  def add_default_avatar
    unless self.avatar_data?
      self.avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_profile.jpg'
          )
        ), filename: 'default_profile.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end

