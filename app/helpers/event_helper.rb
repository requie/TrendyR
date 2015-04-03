module EventHelper
  DATE_FORMAT = '%b %d, %Y'

  def events_caption
    if @profile.user.role?(:label)
      'Upcoming events'
    else
      'My upcoming events'
    end
  end

  def status(model)
    to_start = distance_of_time_in(from: model.started_at)
    to_finish = distance_of_time_in(to: model.finished_at)

    case
    when to_finish < 0
      :past
    when to_start >= 0
      :started
    else
      :pending
    end
  end

  def period(model)
    dates = []
    dates << model.started_at.strftime(DATE_FORMAT)
    dates << model.finished_at.strftime(DATE_FORMAT)
    dates.join(' - ')
  end
end
