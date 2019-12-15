class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :channel_item_id
      t.string :channel_inventory_id
      t.string :price
      t.references :product, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
