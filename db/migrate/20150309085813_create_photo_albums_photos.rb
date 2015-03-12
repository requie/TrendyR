class CreatePhotoAlbumsPhotos < ActiveRecord::Migration
  def change
    create_join_table :photo_albums, :photos do |t|
      t.foreign_key :photo_albums, dependent: :delete
      t.foreign_key :photos, dependent: :delete
    end
  end
end
