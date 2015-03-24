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
    model.photos.first.large.url if model.photos.present?
  end

  def remaining_photos
    model.photos.offset(1).first(5).map { |photo| photo.tiny.url }
  end
end
