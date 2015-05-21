SimpleNavigation::Configuration.run do |navigation|
  navigation.autogenerate_item_ids = false
  navigation.auto_highlight = false

  navigation.name_generator = proc { |name, item|
    content_tag(:i, '', class: item.html_options[:icon]) + content_tag(:span, name)
  }

  navigation.items do |menu|
    menu.item :discover, 'Discover', base_profile_discovery_index_path(:artists), icon: 'icon-globe', class: 'active m-l1'
    menu.item :discover, 'Post a gig', 'javascript: void(0)', icon: 'icon-add', class: 'active m-l1'
    menu.item :discover, 'Search', search_index_path, icon: 'icon-magnify', class: 'active m-l1'

    menu.dom_attributes = { class: 'nav navbar-nav text-uc' }
  end
end
