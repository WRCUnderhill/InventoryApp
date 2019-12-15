class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.integer :level
      t.references :item, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
