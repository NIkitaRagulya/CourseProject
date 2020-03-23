class Comment < ApplicationRecord
    scope :for_item, ->(item) { where(item_id: item.id) }
    belongs_to :item
end
