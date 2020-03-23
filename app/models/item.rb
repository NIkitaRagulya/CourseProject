class Item < ApplicationRecord
    scope :for_collection, ->(collection) { where(collection_id: collection.id) }
    scope :for_item, ->(item) { where(item_id: item.id) }

    has_many :comments

    belongs_to :collection
    has_one_attached :feature_image
end
