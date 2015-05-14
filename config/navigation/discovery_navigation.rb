SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'

  navigation.items do |menu|
    menu.item :gigs, 'Gigs', gigs_base_profile_discovery_index_path, highlights_on: regexp(:gigs)
    menu.item :artists, 'Artist / Djs', base_profile_discovery_index_path(:artists), highlights_on: regexp(:artists)
    menu.item :producers, 'Producers', base_profile_discovery_index_path(:producers), highlights_on: regexp(:producers)
    menu.item :music, 'Music', music_base_profile_discovery_index_path, highlights_on: regexp(:music)
    menu.item :events, 'Show & Events', events_base_profile_discovery_index_path, highlights_on: regexp(:events)
    menu.item :venue, 'Promoters / Venue', base_profile_discovery_index_path(:venues), highlights_on: regexp(:venues)
    menu.item :labels, 'Record labels', base_profile_discovery_index_path(:labels), highlights_on: regexp(:labels)
    menu.item :managers, 'Management', base_profile_discovery_index_path(:managers), highlights_on: regexp(:managers)

    menu.dom_attributes = { class: 'l_tinynav2' }
  end
end
