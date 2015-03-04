module EventHelper
  def events_caption
    if @profile.user.role?(:label)
      'Upcoming events'
    else
      'My upcoming events'
    end
  end
end
