class AddAuthorToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :author, :string
  end
end
