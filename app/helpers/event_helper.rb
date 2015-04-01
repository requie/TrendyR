module EventHelper
  def events_caption
    if @profile.user.role?(:label)
      'Upcoming events'
    else
      'My upcoming events'
    end
  end

  def date_end(event)
    event.finished_at || Time.now
  end

  def date_start(event)
    event.started_at || Time.now
  end
end
