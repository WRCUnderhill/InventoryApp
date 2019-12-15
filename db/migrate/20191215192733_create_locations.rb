class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.string :channel_location_id
      t.string :city
      t.string :country
      t.boolean :nonstocking
      t.references :channel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
