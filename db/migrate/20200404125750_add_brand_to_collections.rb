class AddBrandToCollections < ActiveRecord::Migration[6.0]
  def change
    add_column :collections, :brand, :string
  end
end
