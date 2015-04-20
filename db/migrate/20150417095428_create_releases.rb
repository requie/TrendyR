class CreateReleases < ActiveRecord::Migration
  def change
    create_table :releases do |t|
      t.string :title
      t.text :description_text
      t.datetime :published_at
      t.boolean :is_active

      change_references(t)

      t.timestamps
    end
  end

  def change_references(t)
    t.references :artist
    t.foreign_key :artists

    t.references :photo
    t.foreign_key :photos
  end
end
