class Like < ApplicationRecord
  belongs_to :guest, class_name: 'User'
  belongs_to :event

   after_update_commit -> { broadcast_prepend_later_to(self, locals: { user: current_user, like: self }) }
end
