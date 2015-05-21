SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'active'
  navigation.auto_highlight = true

  navigation.items do |primary|
    primary.item :all, 'All', search_index_path, class: 'search_sidebar_item', link: { class: 'search_sidebar_link' }
    primary.item :artist, 'Artist', resource_search_index_path('artist'), class: 'search_sidebar_item', link: { class: 'search_sidebar_link' }
    primary.item :venue, 'Promoter / venue', resource_search_index_path('venue'), class: 'search_sidebar_item', link: { class: 'search_sidebar_link' }
    primary.item :producer, 'Producer', resource_search_index_path('producer'), class: 'search_sidebar_item', link: { class: 'search_sidebar_link' }
    primary.item :label, 'Label', resource_search_index_path('label'), class: 'search_sidebar_item', link: { class: 'search_sidebar_link' }
    primary.item :manager, 'Manager', resource_search_index_path('manager'), class: 'search_sidebar_item', link: { class: 'search_sidebar_link' }
    primary.item :event, 'Event', event_search_index_path, class: 'search_sidebar_item', link: { class: 'search_sidebar_link' }

    primary.dom_attributes = { class: 'search_sidebar_list' }
  end
end
