SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'menuActive'

  navigation.items do |primary|
    primary.item :profile, 'Home', base_profile_path(@profile)
    primary.item :gigs, 'My gigs', base_profile_gigs_path(@profile),
                 if: proc { show_gigs?(@profile) }
    primary.item :artists, 'Artists', base_profile_artists_path(@profile),
                 if: proc { show_item_artists?(@profile) }
    primary.item :releases, 'Releases', base_profile_releases_path(@profile),
                 if: proc { show_item_releases?(@profile) }
    primary.item :events, 'My events', base_profile_events_path(@profile),
                 if: proc { @profile.user.role?(:artist) }
    primary.item :calendar, 'Calendar', base_profile_calendar_index_path(@profile),
                 if: proc { show_item_calendar?(@profile) }
    primary.item :awards, 'Awards', base_profile_awards_path(@profile),
                 if: proc { show_awards?(@profile) }
    primary.item :press_kit, 'Press Kit', '#',
                 if: proc { show_item_press_kit?(@profile) }
    primary.item :gallery, 'Gallery', base_profile_gallery_index_path(@profile),
                 if: proc { @profile.user.role?(:venue) }

    primary.dom_attributes = { class: 'nav-page l_tinynav1' }
  end
end
