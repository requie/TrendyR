class CreatePhotoAlbums < ActiveRecord::Migration
  def change
    create_table :photo_albums do |t|
      t.string :title
      t.boolean :is_active, default: true

      change_references(t)

      t.timestamps
    end
  end

  def change_references(t)
    t.references :owner_profile
    t.foreign_key :profiles, column: :owner_profile_id
  end
end
