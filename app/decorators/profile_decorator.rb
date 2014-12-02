class ProfileDecorator < Draper::Decorator
  def photo_url(style = nil)
    object.photo.present? ? object.photo.url(style) : ''
  end

  def wallpaper_url(style = nil)
    object.wallpaper.present? ? object.wallpaper.url(style) : ''
  end
end
