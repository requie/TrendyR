module ProfileHelper
  DEFAULT_PROFILE_WALLPAPER = 'background/profile.png'
  DEFAULT_PROFILE_AVATAR = 'icons/avatar-user.png'

  def get_address(location)
    location ? location.address : ''
  end

  def wallpaper_url(model)
    if model.wallpaper
      model.wallpaper.cropped
    else
      asset_url(DEFAULT_PROFILE_WALLPAPER)
    end
  end

  def avatar_url(model)
    if model.photo
      model.photo.with_presets([:cropped, :private_hompage])
    else
      asset_url(DEFAULT_PROFILE_AVATAR)
    end
  end

  private

  def days_in_this_month
    Time.now.end_of_month.day
  end

  def get_distance(started_at, finished_at)
    to_start = distance_of_time_in(:days, to: started_at)
    to_finish = distance_of_time_in(:hours, to: finished_at)
    result_hash = {}
    if to_start > 0
      if to_start > days_in_this_month
        result_hash[:label] = "#{distance_of_time_in(:months, to: started_at)} MTH"
        result_hash[:class] = 'month'
      else
        result_hash[:label] = "#{to_start} DAYS"
        result_hash[:class] = 'days'
      end
    elsif to_finish >= 0
      result_hash[:label] = 'NOW'
      result_hash[:class] = 'now'
    end
    result_hash
  end
end
