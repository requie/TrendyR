SimpleNavigation::Configuration.run do |navigation|
  navigation.renderer = AdminMenuRenderer
  navigation.autogenerate_item_ids = false
  navigation.selected_class = 'active'

  navigation.items do |primary|
    primary.item :dashboard, 'Dashboard', admin_dashboard_index_path
    primary.item :homepage, 'Homepage', '#' do |sub_nav|
      sub_nav.item :gigs, 'Gigs', admin_gigs_path
      sub_nav.item :artists, 'Artists', admin_artists_path
      sub_nav.item :features, 'Features', admin_features_path
    end

    primary.dom_attributes = { class: 'nav', id: 'side-menu' }
  end
end
