SimpleNavigation::Configuration.run do |navigation|
  navigation.autogenerate_item_ids = false
  navigation.auto_highlight = false

  navigation.name_generator = proc { |name, item|
    (icon = item.html_options[:icon]) ? content_tag(:i, '', class: icon) + name : name
  }

  navigation.items do |menu|
    menu.item :booking, 'Booking Invitation', base_profile_bookings_path, icon: 'icon-invitation', if: proc { current_user.role?(:artist) }
    menu.item :settings, 'Profile Settings', base_profile_settings_path, icon: 'icon-settings'
    menu.item :messages, 'Messages', base_profile_conversations_path, icon: 'icon-mes'
    menu.item :music, 'Payments', base_profile_payments_path, icon: 'icon-pay'
    menu.item :logout, 'Log Out', destroy_user_session_path, icon: 'icon-logOut'

    menu.dom_attributes = { class: 'dropdown-menu userInform', role: 'menu', 'aria-labelledby' => 'dLabel' }
  end
end
