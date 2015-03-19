class PhotoAlbumDecorator < ApplicationDecorator
  delegate_all
  DATE_OF_CREATION_FORMAT = '%B %d, %Y'

  def date_of_creation
    object.created_at.strftime(DATE_OF_CREATION_FORMAT) if object.created_at
  end

  def number_of_photos
    object.photos.length
  end
end
