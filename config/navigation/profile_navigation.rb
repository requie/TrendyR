SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'menuActive'
  navigation.auto_highlight = true

  navigation.items do |primary|
    primary.item :profile, 'Home', public_profile_path(@profile)
    primary.item :gigs, 'My gigs', public_profile_gigs_path(@profile), if: proc { show_public_gigs?(@profile) }
    primary.item :artists, 'Artists', public_profile_artists_path(@profile), if: proc { show_public_artists?(@profile) }
    primary.item :releases, 'Releases', public_profile_releases_path(@profile), if: proc { show_public_releases?(@profile) }
    primary.item :calendar, 'Calendar', public_profile_events_path(@profile), if: proc { show_public_calendar?(@profile) }
    primary.item :awards, 'Awards', public_profile_awards_path(@profile), if: proc { show_public_awards?(@profile) }
    primary.item :press_kit, 'Press Kit', public_profile_press_kit_path(@profile), if: proc { show_public_press_kit?(@profile) }
    primary.item :gallery, 'Gallery', public_profile_photo_albums_path(@profile), if: proc { show_public_gallery?(@profile) }

    primary.dom_attributes = { class: 'nav-page' }
  end
end
