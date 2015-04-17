SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'menuActive'

  navigation.items do |primary|
    primary.item :profile, 'Home', base_profile_path
    primary.item :gigs, 'My gigs', base_profile_gigs_path,
                 if: proc { show_gigs?(@profile) }
    primary.item :music, 'My music', '#', if: proc { show_music?(@profile) }
    primary.item :artists, 'Artists', '#',
                 if: proc { show_item_artists?(@profile) }
    primary.item :releases, 'Releases', '#',
                 if: proc { show_private_item_releases?(@profile) }
    primary.item :events, 'My events', base_profile_events_path,
                 if: proc { show_private_item_events?(@profile) }
    primary.item :awards, 'Awards', base_profile_awards_path,
                 if: proc { show_awards?(@profile) }
    primary.item :press_kit, 'Press kit', '#',
                 if: proc { show_item_press_kit?(@profile) }
    primary.item :gallery, 'My gallery', base_profile_galleries_path,
                 if: proc { @profile.user.role?(:venue) }

    primary.dom_attributes = { class: 'nav-page' }
  end
end
