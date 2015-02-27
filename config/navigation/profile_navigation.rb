SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'menuActive'

  navigation.items do |primary|
    primary.item :home, 'Home', base_profile_path
    primary.item :gigs, 'My gigs', '#', if: proc { policy(@profile).show_gigs? }
    primary.item :artists, 'Artists', '#', if: proc { policy(@profile).show_item_artists? }
    primary.item :releases, 'Releases', '#', if: proc { policy(@profile).show_item_releases? }
    primary.item :events, 'My events', '#', if: proc { @profile.user.role?(:artist) }
    primary.item :calendar, 'Calendar', '#', if: proc { policy(@profile).show_item_calendar? }
    primary.item :awards, 'Awards', '#', if: proc { policy(@profile).show_awards? }
    primary.item :press_kit, 'Press kit', '#', if: proc { policy(@profile).show_item_press_kit? }
    primary.item :gallery, 'Gallery', '#', if: proc { @profile.user.role?(:venue) }
  end
end
