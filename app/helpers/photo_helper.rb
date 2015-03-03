module PhotoHelper
  def photos_caption
    if @profile.user.role?(:artist)
      'My photos'
    elsif @profile.user.role?(:venue)
      'My gallery'
    end
  end
end
