SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'menuActive'

  navigation.items do |primary|
    primary.item :home, 'Home', base_profile_path
    primary.item :gigs, 'My gigs', gigs_base_profile_path, if: proc { policy(@profile).show_gigs? }
    primary.item :artists, 'Artists', artists_base_profile_path, if: proc { policy(@profile).show_item_artists? }
    primary.item :releases, 'Releases', releases_base_profile_path, if: proc { policy(@profile).show_item_releases? }
    primary.item :events, 'My events', '#', if: proc { @profile.user.role?(:artist) }
    primary.item :calendar, 'Calendar', calendar_base_profile_path, if: proc { policy(@profile).show_item_calendar? }
    primary.item :awards, 'Awards', awards_base_profile_path, if: proc { policy(@profile).show_awards? }
    primary.item :press_kit, 'Press Kit', '#', if: proc { policy(@profile).show_item_press_kit? }
    primary.item :gallery, 'Gallery', gallery_base_profile_path, if: proc { @profile.user.role?(:venue) }

    primary.dom_attributes = { class: 'nav-page l_tinynav1' }
  end
end
