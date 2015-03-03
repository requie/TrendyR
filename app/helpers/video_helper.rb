module VideoHelper
  def videos_caption
    if @profile.user.role?(:artist)
      'My videos'
    elsif @profile.user.role?(:label)
      'Recent videos'
    end
  end
end
