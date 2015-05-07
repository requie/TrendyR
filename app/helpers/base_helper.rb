module BaseHelper
  ACCESS = {
    private: {
      artist: [:home, :gigs, :music, :events, :press_kit],
      venue: [:home, :gigs, :events, :gallery],
      producer: [:home, :artists, :releases_list, :awards],
      manager: [:home, :artists],
      label: [:home, :artists, :releases, :events, :awards]
    },
    public: {
      artist: [:home, :gigs, :releases, :events, :calendar, :press_kit, :photos, :music, :videos],
      venue: [:home, :gigs, :events, :calendar, :gallery, :photos, :location],
      producer: [:home, :artists, :releases, :awards, :location],
      manager: [:home, :artists, :calendar, :location, :events],
      label: [:home, :artists, :releases, :calendar, :awards, :videos, :location, :events]
    }
  }

  ACCESS.keys.each do |type|
    ACCESS.values.map(&:values).flatten.uniq.each do |menu|
      define_method("show_#{type}_#{menu}?") do |profile|
        role = profile.user.role.name.underscore.to_sym
        ACCESS[type][role].include?(menu)
      end
    end
  end

  def distance_of_time_in(unit = :hours, from: Time.now, to: Time.now)
    ((to - from) / 1.send(unit)).round
  end

  def render_empty(name_sym)
    content_tag(:p, class: 'emptyBlock m-t20') do
      "No #{name_sym.downcase}"
    end
  end

  def container_class
    css_class = 'container pg'
    if controller_name == 'conversations' && action_name == 'show'
      css_class << ' message_list'
    end
    css_class
  end
end
