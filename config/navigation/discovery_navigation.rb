SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |menu|
    menu.item :gigs, 'Gigs', gigs_base_profile_discovery_index_path
    menu.item :artists, 'Artist / Djs', artists_base_profile_discovery_index_path
    menu.item :producers, 'Producers', producers_base_profile_discovery_index_path
    menu.item :music, 'Music', music_base_profile_discovery_index_path
    menu.item :events, 'Show & Events', events_base_profile_discovery_index_path
    menu.item :venue, 'Promoters / Venue', venues_base_profile_discovery_index_path
    menu.item :labels, 'Record labels', labels_base_profile_discovery_index_path
    menu.item :managers, 'Management', managers_base_profile_discovery_index_path

    menu.dom_attributes = { class: 'l_tinynav2' }
  end
end
