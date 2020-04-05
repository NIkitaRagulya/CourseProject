class AddYearOfPublishingToCollections < ActiveRecord::Migration[6.0]
  def change
    add_column :collections, :year_of_publishing, :string
  end
end
