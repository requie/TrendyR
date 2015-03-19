class PhotoAlbumDecorator < ApplicationDecorator
  delegate_all
  decorates_association :photos
  DATE_OF_CREATION_FORMAT = '%B %d, %Y'

  def date_of_creation
    model.created_at.strftime(DATE_OF_CREATION_FORMAT) if model.created_at
  end

  def number_of_photos
    model.photos.count
  end

  def first_photo
    model.photos.first.thumb('200x130#')
  end

  def five_without_first
    model.photos.offset(1).first(5)
  end
end
