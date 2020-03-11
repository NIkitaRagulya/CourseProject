class Post < ApplicationRecord
  validates :title, presence: true, length: {minimum: 5}

  scope :for_user, ->(user) { where(user_id: user.id) }

  belongs_to :user
end
