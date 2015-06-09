SimpleNavigation::Configuration.run do |navigation|
  navigation.autogenerate_item_ids = false
  navigation.auto_highlight = false

  navigation.items do |menu|
    menu.item :booking, 'Discover', discovery_index_path(:artists)
    menu.item :settings, 'Post a gig', '#'
    menu.item :messages, 'How it works', '#'
    menu.item :music, 'Features', '#'
    menu.item :logout, 'About', '#'
    menu.item :logout, 'FAQ', static_page_path(:faq)
    menu.item :logout, 'Contact', static_page_path(:contact)
    menu.item :logout, 'Blog', '#'

    menu.dom_attributes = { class: 'navbar navbar-nav navbar-left p-l0', id: 'foo-menu' }
  end
end
