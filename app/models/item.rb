class Item < ApplicationRecord
    scope :for_collection, ->(collection) { where(collection_id: collection.id) }
    scope :for_item, ->(item) { where(item_id: item.id) }

    acts_as_votable

    has_many :comments
    has_many :taggings
    has_many :tags, through: :taggings

    belongs_to :collection
    has_one_attached :feature_image

    def all_tags
        self.tags.map(&:name).join(', ')
    end

    def all_tags=(names)
        self.tags = names.split(',').map do |name|
            Tag.where(name: name.strip).first_or_create!
        end
    end

    validates :description, length: { maximum: 380,
        too_long: "%{count} characters is the maximum allowed" }

    validates :name, length: { maximum: 35,
        too_long: "%{count} characters is the maximum allowed" }

    validates :name, :description, presence: true
end
