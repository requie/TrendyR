class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :website
      t.text :description_text
      t.string :spotify_url
      t.string :rdio_url
      t.string :facebook_url
      t.string :twitter_url
      t.string :google_plus_url
      t.string :instagram_url
      t.boolean :is_active, default: true

      change_references(t)

      t.timestamps
    end
  end

  # because of rubocop
  def change_references(t)
    t.references :user
    t.foreign_key :users, dependent: :delete

    t.references :photo
    t.foreign_key :photos

    t.references :wallpaper
    t.foreign_key :photos, column: :wallpaper_id
  end
end
