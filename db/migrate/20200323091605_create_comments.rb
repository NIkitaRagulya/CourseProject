class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :item_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
