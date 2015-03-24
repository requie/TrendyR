class PhotoAlbumPhoto < ActiveRecord::Base
  self.table_name = 'photo_albums_photos'

  belongs_to :photo, dependent: :destroy
  belongs_to :photo_album
end
