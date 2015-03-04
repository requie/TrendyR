SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'menuActive'

  navigation.items do |primary|
    primary.item :home, 'Home', base_profile_path
    primary.item :gigs, 'My gigs', base_gigs_show_path(@profile.id), if: proc { policy(@profile).show_gigs? }
    primary.item :artists, 'Artists', base_artists_path(@profile.id), if: proc { policy(@profile).show_item_artists? }
    primary.item :releases, 'Releases', base_releases_path(@profile.id), if:
                              proc { policy(@profile).show_item_releases? }
    primary.item :events, 'My events', base_events_path(@profile.id), if: proc { @profile.user.role?(:artist) }
    primary.item :calendar, 'Calendar', base_calendar_path(@profile.id), if:
                              proc { policy(@profile).show_item_calendar? }
    primary.item :awards, 'Awards', base_awards_show_path(@profile.id), if: proc { policy(@profile).show_awards? }
    primary.item :press_kit, 'Press Kit', '#', if: proc { policy(@profile).show_item_press_kit? }
    primary.item :gallery, 'Gallery', base_gallery_path(@profile.id), if:
                             proc { @profile.user.role?(:venue) }

    primary.dom_attributes = { class: 'nav-page l_tinynav1' }
  end
end
