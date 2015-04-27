SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'menuActive'

  navigation.items do |primary|
    primary.item :profile, 'Home', base_profile_path
    primary.item :gigs, 'My gigs', base_profile_gigs_path,
                 if: proc { show_private_gigs?(@profile) }
    primary.item :music, 'My music', base_profile_releases_path,
                 if: proc { show_private_music?(@profile) }
    primary.item :artists, 'Artists', base_profile_artists_path,
                 if: proc { show_private_artists?(@profile) }
    primary.item :events, 'My events', base_profile_events_path,
                 if: proc { show_private_events?(@profile) }
    primary.item :awards, 'Awards', base_profile_awards_path,
                 if: proc { show_private_awards?(@profile) }
    primary.item :press_kit, 'Press kit', base_profile_press_kits_path,
                 if: proc { show_private_press_kit?(@profile) }
    primary.item :gallery, 'My gallery', base_profile_galleries_path,
                 if: proc { show_private_gallery?(@profile) }

    primary.dom_attributes = { class: 'nav-page' }
  end
end
