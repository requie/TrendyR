SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'menuActive'
  navigation.auto_highlight = true

  navigation.items do |primary|
    primary.item :profile, 'Home', public_profile_path(@profile)
    primary.item :gigs, 'My gigs', '#', if: proc { show_public_gigs?(@profile) }
    primary.item :artists, 'Artists', '#', if: proc { show_public_artists?(@profile) }
    primary.item :releases, 'Releases', '#', if: proc { show_public_releases?(@profile) }
    primary.item :calendar, 'Calendar', '#', if: proc { show_public_calendar?(@profile) }
    primary.item :awards, 'Awards', '#', if: proc { show_public_awards?(@profile) }
    primary.item :press_kit, 'Press Kit', '#', if: proc { show_public_press_kit?(@profile) }
    primary.item :gallery, 'Gallery', '#', if: proc { show_public_gallery?(@profile) }

    primary.dom_attributes = { class: 'nav-page' }
  end
end
