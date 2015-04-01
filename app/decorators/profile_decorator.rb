class ProfileDecorator < ApplicationDecorator
  delegate_all
  decorates_association :owned_awards
  DEFAULT_PROFILE_WALLPAPER = 'background/profile.png'
  DEFAULT_PROFILE_AVATAR = 'icons/avatar-user.png'

  def name_placeholder
    "#{model.entity.class.name} Name"
  end

  def wallpaper_url
    if model.wallpaper
      model.wallpaper.cropped
    else
      h.asset_url(DEFAULT_PROFILE_WALLPAPER)
    end
  end

  def avatar_url
    if model.photo
      model.photo.with_presets([:cropped, :homepage])
    else
      h.asset_url(DEFAULT_PROFILE_AVATAR)
    end
  end
end
