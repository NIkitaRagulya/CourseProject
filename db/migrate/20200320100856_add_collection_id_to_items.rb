class AddCollectionIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :collection_id, :integer
  end
end
