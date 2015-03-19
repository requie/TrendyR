class PhotoAlbum < ActiveRecord::Base
  include Ownable

  has_many :photo_album_photos
  has_many :photos, through: :photo_album_photos

  def owned_by?(profile)
    profile == owner_profile
  end
end
