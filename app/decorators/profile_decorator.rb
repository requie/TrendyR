class ProfileDecorator < ApplicationDecorator
  delegate_all
  decorates_association :owned_awards

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
      'background/profile.png'
    end
  end

  def avatar_url
    if object.photo
      object.photo.cropped_photo.url
    else
      'icons/avatar-user.png'
    end
  end
end
