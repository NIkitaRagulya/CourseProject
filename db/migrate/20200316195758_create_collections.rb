class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.string :name
      t.text :description
      t.string :topic
      t.integer :user_id

      t.timestamps
    end
  end
end
