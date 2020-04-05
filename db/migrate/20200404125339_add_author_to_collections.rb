class AddAuthorToCollections < ActiveRecord::Migration[6.0]
  def change
    add_column :collections, :author, :string
  end
end
