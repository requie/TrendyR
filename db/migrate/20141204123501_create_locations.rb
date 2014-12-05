class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :source
      t.string :source_id
      t.string :source_place_id
      t.string :address
      t.string :types
      t.decimal :latitude
      t.decimal :longitude

      t.references :creator
      t.foreign_key :users, column: :creator_id

      t.timestamps
    end
  end
end
