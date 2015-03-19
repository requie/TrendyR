class ProfileDecorator < ApplicationDecorator
  delegate_all
  decorates_association :owned_awards
  decorates_association :owned_photo_albums
  DEFAULT_PROFILE_WALLPAPER = 'background/profile.png'
  DEFAULT_PROFILE_AVATAR = 'icons/avatar-user.png'

  def location_address
    model.location.address if model.location
  end

  def name_placeholder
    "#{model.entity.class.name} Name"
  end

  def wallpaper_url
    if model.wallpaper
      model.wallpaper.cropped_photo.url
    else
      DEFAULT_PROFILE_WALLPAPER
    end
  end

  def avatar_url
    if model.photo
      model.photo.cropped_photo.url
    else
      DEFAULT_PROFILE_AVATAR
    end
  end
end
