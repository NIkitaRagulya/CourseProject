class Item < ApplicationRecord
    scope :for_collection, ->(collection) { where(collection_id: collection.id) }

    belongs_to :collection
    has_one_attached :feature_image
end
