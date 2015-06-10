SimpleNavigation::Configuration.run do |navigation|
  navigation.autogenerate_item_ids = false
  navigation.auto_highlight = false

  navigation.name_generator = proc { |name, item|
    (icon = item.html_options[:icon]) ? content_tag(:i, '', class: icon) + name : name
  }

  navigation.items do |menu|
    menu.item :booking, 'Booking Invitation', private_bookings_path, icon: 'icon-invitation',
              if: proc { current_user.role?(:artist) }
    menu.item :settings, 'Profile Settings', settings_path, icon: 'icon-settings'
    menu.item :messages, 'Messages', conversations_path, icon: 'icon-mes'
    menu.item :payments, 'Payments', payments_path, icon: 'icon-pay',
              if: proc { current_user.role?(:artist) }
    menu.item :logout, 'Log Out', destroy_user_session_path, icon: 'icon-logOut'

    menu.dom_attributes = { class: 'dropdown-menu userInform', role: 'menu', 'aria-labelledby' => 'dLabel' }
  end
end
