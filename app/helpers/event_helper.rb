module EventHelper
  DATE_FORMAT = '%b %d, %Y'
  GROUP_DATE_FORMAT = '%B %d, %Y'

  def events_caption
    if @profile.user.role?(:label)
      'Upcoming events'
    else
      'My upcoming events'
    end
  end

  def photo_with_promo_logo(model, link)
    distance = get_distance(model.started_at, model.finished_at)
    content_tag :div, class: "promo-logo-#{distance[:class] || :now}" do
      link_to link do
        concat image(model)
        concat content_tag :div, distance[:label], class: "logo-#{distance[:class]}" if distance[:label]
      end
    end
  end

  def image(model)
    image_tag model.photo.with_presets([:cropped, :medium]), class: 'mobile-center'
  end

  def big_date(date)
    content_tag :div, class: 'eventDate w-sm-30 w-xs-45' do
      concat number_span(date.day)
      concat content_tag :h4, Date::MONTHNAMES[date.month], class: 'm-t5'
      concat content_tag :h4, date.year
    end
  end

  def without_filters?
    params[:q].nil? || params[:q].values.try(:join).empty?
  end

  def grouped_events
    @events.pending.group_by(&:started_at) if without_filters?
  end

  def formatted_date(date)
    date.strftime(GROUP_DATE_FORMAT)
  end

  def events_today
    @events.started
  end

  def events_tomorrow
    @events.at_date(Date.tomorrow)
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

  private

  def number_span(number)
    content_tag :h4 do
      content_tag :span, number
    end
  end
end
