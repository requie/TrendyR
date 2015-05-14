SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.auto_highlight = true

  navigation.items do |menu|
    menu.item :gigs, 'Gigs', gigs_base_profile_discovery_index_path
    menu.item :artists, 'Artist / Djs', base_profile_discovery_index_path(:artists)
    menu.item :producers, 'Producers', base_profile_discovery_index_path(:producers)
    menu.item :music, 'Music', music_base_profile_discovery_index_path
    menu.item :events, 'Show & Events', events_base_profile_discovery_index_path
    menu.item :venue, 'Promoters / Venue', base_profile_discovery_index_path(:venues)
    menu.item :labels, 'Record labels', base_profile_discovery_index_path(:labels)
    menu.item :managers, 'Management', base_profile_discovery_index_path(:managers)

    menu.dom_attributes = { class: 'l_tinynav2' }
  end
end
