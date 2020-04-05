class AddItemsQuantityToCollection < ActiveRecord::Migration[6.0]
  def change
    add_column :collections, :items_quantity, :integer
  end
end
