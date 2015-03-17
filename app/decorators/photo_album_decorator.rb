class PhotoAlbumDecorator < ApplicationDecorator
  delegate_all

  def date_of_creation
    object.created_at.strftime('%B %d, %Y') if object.created_at
  end
end