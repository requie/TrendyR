module SearchHelper
  LABELS = {
    artist: 'Artist, DJ',
    venue: 'Promoter / venue',
    producer: 'Producer',
    label: 'Label',
    manager: 'Manager',
    event: 'Events'
  }

  def search_result_label(label_type)
    LABELS[label_type.to_sym]
  end

  def search_result_label_with_count(label_type, count)
    "#{LABELS[label_type.to_sym]} (#{count})"
  end

  def link_to_resource(type)
    type == 'event' ? event_search_index_path : resource_search_index_path(type)
  end

  def event_label(event)
    current = Date.current
    started, finished = event.started.to_date, event.finished.to_date
    if started > current && finished < current
      content_tag(:div, 'NOW', class: 'logo-now')
    else
      days = finished - current
      if days < 31
        content_tag(:div, "#{days} days", class: 'logo-days')
      else
        content_tag(:div, "#{(days / 30).ceil} MTH", class: 'logo-month')
      end
    end
  end
end
