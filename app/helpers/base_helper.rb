module BaseHelper
  def show_gigs?(profile)
    profile.user.roles? %w(artist venue)
  end

  def show_events?(profile)
    profile.user.roles? %w(artist label manager venue)
  end

  def show_awards?(profile)
    profile.user.roles? %w(label producer)
  end

  def show_photos?(profile)
    profile.user.roles? %w(artist venue)
  end

  def show_music?(profile)
    profile.user.role?(:artist)
  end

  def show_videos?(profile)
    profile.user.roles? %w(artist label)
  end

  def show_location?(profile)
    profile.user.roles? %w(label manager producer venue)
  end

  def show_item_artists?(profile)
    profile.user.roles? %w(label manager producer)
  end

  def show_item_releases?(profile)
    profile.user.roles? %w(artist label producer)
  end

  def show_item_calendar?(profile)
    profile.user.roles? %w(label manager venue)
  end

  def show_item_press_kit?(profile)
    profile.user.role?(:artist)
  end
end
