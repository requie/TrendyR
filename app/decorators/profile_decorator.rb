class ProfileDecorator < ApplicationDecorator
  delegate_all
  decorates_association :owned_awards
  DEFAULT_PROFILE_WALLPAPER = 'background/profile.png'
  DEFAULT_PROFILE_AVATAR = 'icons/avatar-user.png'

  def location_address
    object.location.address if object.location
  end

  def name_placeholder
    "#{object.entity.class.name} Name"
  end

  def wallpaper_url
    if object.wallpaper
      object.wallpaper.cropped_photo.url
    else
      DEFAULT_PROFILE_WALLPAPER
    end
  end

  def avatar_url
    if object.photo
      object.photo.cropped_photo.url
    else
      DEFAULT_PROFILE_AVATAR
    end
  end
end
