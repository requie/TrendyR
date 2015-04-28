SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'menuActive'

  navigation.items do |primary|
    primary.item :profile, 'Home', base_public_profile_path(@profile)
    primary.item :gigs, 'My gigs', base_public_profile_public_gigs_path(@profile),
                 if: proc { show_public_gigs?(@profile) }
    primary.item :artists, 'Artists', base_public_profile_artists_path(@profile),
                 if: proc { show_public_artists?(@profile) }
    primary.item :releases, 'Releases', base_public_profile_public_releases_path(@profile),
                 if: proc { show_public_releases?(@profile) }
    primary.item :calendar, 'Calendar', base_public_profile_events_path(@profile),
                 if: proc { show_public_calendar?(@profile) }
    primary.item :awards, 'Awards', base_public_profile_public_awards_path(@profile),
                 if: proc { show_public_awards?(@profile) }
    primary.item :press_kit, 'Press Kit', base_public_profile_press_kit_path(@profile),
                 if: proc { show_public_press_kit?(@profile) }
    primary.item :gallery, 'Gallery', base_public_profile_gallery_path(@profile),
                 if: proc { show_public_gallery?(@profile) }

    primary.dom_attributes = { class: 'nav-page' }
  end
end
