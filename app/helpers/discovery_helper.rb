module DiscoveryHelper
  SIDEBAR = {
    artist: {
      show: %w(top featured new)
    },
    gig: {
      type: %w(live licensing contest),
      show: %w(free_to_apply pay_to_apply compensated near_me)
    },
    manager: {
      type: %w(artist musician djs)
    },
    music: {
      type: %w(artist musician band),
      show: %w(top featured new)
    },
    producer: {
      type: %w(artist musician featured band),
      variation: %w(all concerts tv events)
    },
    venue: {
      type: %w(concerts events festivals)
    },
    label: {
      type: %w(artist musician djs),
      variation: %w(all concerts djs tv events radio),
      skill: %w(1-3_years 3-5_years 5-10_years)
    },
    event: {
      type: %w(concert event festival),
      show: %w(free pay)
    }
  }

  def sidebar(type)
    list = SIDEBAR[type.to_sym].map do |title, options|
      [
        content_tag(:h4, title.to_s.humanize),
        collection_check_boxes(:discovery, :genre_ids, options, :to_s, :humanize) do |cb|
          cb.label(class: 'cb-checkbox') { cb.check_box + cb.text } + content_tag(:div, nil, class: 'clearfix')
        end
      ].join
    end
    content_tag(:div, class: 'sorting custom-form') do
      concat content_tag(:i, '', class: 'icon-close')
      concat list.join.html_safe
      concat genres
    end
  end

  def additional_class
    case @type
    when 'venue' then 'discovery-promoters-banner'
    when 'artist' then 'discovery-banner clearfix'
    when 'label' then 'discovery-label-banner'
    when 'manager' then 'discovery-managers-banner'
    when 'producer' then 'discovery-producer-banner'
    end
  end

  def regexp(type)
    %r{profile/discovery/#{type}}
  end

  private

  def genres
    [
      content_tag(:h4, 'Genres'),
      collection_check_boxes(:discovery, :genre_ids, Genre.all, :id, :name) do |cb|
        cb.label(class: 'cb-checkbox') { cb.check_box + cb.text } + content_tag(:div, nil, class: 'clearfix')
      end
    ].join.html_safe
  end
end
