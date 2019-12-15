class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :channel_product_id
      t.string :label_1
      t.string :label_2
      t.string :label_3
      t.references :channel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
