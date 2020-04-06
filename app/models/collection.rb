class Collection < ApplicationRecord
    has_many :items

    scope :for_user, ->(user) { where(user_id: user.id) }

    belongs_to :user
    has_one_attached :feature_image

    validates :description, length: { maximum: 380,
        too_long: "%{count} characters is the maximum allowed" }

    validates :name, length: { maximum: 35,
        too_long: "%{count} characters is the maximum allowed" }

    validates :name, :description, presence: true
end
