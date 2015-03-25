SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'menuActive'

  navigation.items do |primary|
    primary.item :profile, 'Home', edit_base_profile_path(@profile)
    primary.item :gigs, 'My gigs', base_profile_gigs_path(@profile),
                 if: proc { show_gigs?(@profile) }
    primary.item :music, 'My music', '#', if: proc { show_music?(@profile) }
    primary.item :artists, 'Artists', base_profile_artists_path(@profile),
                 if: proc { show_item_artists?(@profile) }
    primary.item :releases, 'Releases', base_profile_releases_path(@profile),
                 if: proc { show_private_item_releases?(@profile) }
    primary.item :events, 'My events', edit_base_profile_calendar_path(@profile),
                 if: proc { show_private_item_events?(@profile) }
    primary.item :awards, 'Awards', base_profile_awards_path(@profile),
                 if: proc { show_awards?(@profile) }
    primary.item :press_kit, 'Press kit', '#',
                 if: proc { show_item_press_kit?(@profile) }
    primary.item :gallery, 'My gallery', edit_base_profile_gallery_path(@profile),
                 if: proc { @profile.user.role?(:venue) }

    primary.dom_attributes = { class: 'nav-page' }
  end
end
