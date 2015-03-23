class PhotoAlbum < ActiveRecord::Base
  include Ownable
  paginates_per 12

  has_many :photo_album_photos
  has_many :photos, through: :photo_album_photos, dependent: :destroy

  def owned_by?(profile)
    profile == owner_profile
  end
end
