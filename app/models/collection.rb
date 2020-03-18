class Collection < ApplicationRecord

    scope :for_user, ->(user) { where(user_id: user.id) }

    belongs_to :user
    has_one_attached :feature_image
end
