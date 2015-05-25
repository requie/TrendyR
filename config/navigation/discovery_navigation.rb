SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.auto_highlight = true

  navigation.items do |menu|
    menu.item :gigs, 'Gigs', gigs_discovery_index_path
    menu.item :artists, 'Artist / Djs', discovery_index_path(:artists)
    menu.item :producers, 'Producers', discovery_index_path(:producers)
    menu.item :music, 'Music', music_discovery_index_path
    menu.item :events, 'Show & Events', events_discovery_index_path
    menu.item :venue, 'Promoters / Venue', discovery_index_path(:venues)
    menu.item :labels, 'Record labels', discovery_index_path(:labels)
    menu.item :managers, 'Management', discovery_index_path(:managers)

    menu.dom_attributes = { class: 'l_tinynav2' }
  end
end
