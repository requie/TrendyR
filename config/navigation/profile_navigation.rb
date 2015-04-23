SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'menuActive'

  navigation.items do |primary|
    primary.item :profile, 'Home', base_public_profile_path(@profile)
    primary.item :gigs, 'My gigs', base_public_profile_public_gigs_path(@profile),
                 if: proc { show_gigs?(@profile) }
    primary.item :artists, 'Artists', base_public_profile_artists_path(@profile),
                 if: proc { show_item_artists?(@profile) }
    primary.item :releases, 'Releases', '#',
                 if: proc { show_item_releases?(@profile) }
    primary.item :calendar, 'Calendar', base_public_profile_events_path(@profile),
                 if: proc { show_item_calendar?(@profile) }
    primary.item :awards, 'Awards', base_public_profile_public_awards_path(@profile),
                 if: proc { show_awards?(@profile) }
    primary.item :press_kit, 'Press Kit', '#',
                 if: proc { show_item_press_kit?(@profile) }
    primary.item :gallery, 'Gallery', base_public_profile_gallery_path(@profile),
                 if: proc { @profile.user.role?(:venue) }

    primary.dom_attributes = { class: 'nav-page' }
  end
end
