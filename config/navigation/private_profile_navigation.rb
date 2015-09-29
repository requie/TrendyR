SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'menuActive'
  navigation.auto_highlight = true

  navigation.items do |primary|
    primary.item :profile, 'Home', private_profile_path
    primary.item :gigs, 'My gigs', private_gigs_path, if: proc { policy(Gig).index? }
    primary.item :music, 'My music', private_releases_path, if: proc { policy(Release).index? }
    primary.item :artists, 'Artists', private_artists_path, if: proc { policy(Artist).index? }
    primary.item :events, 'My events', private_events_path, if: proc { policy(Event).index? }
    primary.item :releases, 'Releases', list_private_releases_path, if: proc { policy(Release).list? }
    primary.item :awards, 'Awards', private_awards_path, if: proc { policy(Award).index? }
    primary.item :press_kit, 'Press kit', private_profile_press_kit_path, if: proc { current_user.role?(:artist) }
    primary.item :gallery, 'My gallery', private_photo_albums_path, if: proc { policy(PhotoAlbum).index? }
    primary.item :gallery, 'My Bookings', private_bookings_path

    primary.dom_attributes = { class: 'nav-page' }
  end
end
