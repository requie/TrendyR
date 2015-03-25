class PhotoAlbumPhoto < ActiveRecord::Base
  self.table_name = 'photo_albums_photos'

  belongs_to :photo, class_name: 'PhotoAlbum::Photo', dependent: :destroy
  belongs_to :photo_album
end
