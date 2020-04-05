class AddYearOfPublishingToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :year_of_publishing, :integer
  end
end
