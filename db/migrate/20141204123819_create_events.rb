class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description_text
      t.decimal :price
      t.datetime :started_at
      t.datetime :finished_at
      t.boolean :is_active, default: true

      change_references(t)

      t.timestamps
    end
  end

  def change_references(t)
    t.references :owner_profile
    t.foreign_key :profiles, column: :owner_profile_id

    t.references :location
    t.foreign_key :locations

    t.references :photo
    t.foreign_key :photos
  end
end
