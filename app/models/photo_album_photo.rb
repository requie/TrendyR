class PhotoAlbumPhoto < ActiveRecord::Base
  self.table_name = 'photo_albums_photos'

  belongs_to :photo
  belongs_to :photo_album
end
