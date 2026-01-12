Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Enable public file server for development
  config.public_file_server.enabled = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Configure mailer
  # Mailcatcher gem is used to test emails locally
  #config.action_mailer.default_url_options = {
  #  host: Rails.application.secrets['host'],
  #  port: Rails.application.secrets['port']
  #}
 # config.action_mailer.delivery_method = :smtp

  # Mailcatcher settings, use either this or thing below
  #config.action_mailer.smtp_settings = {
  #  address: 'localhost',
  #  port: 1025
  #}

  # Set mailer default options
  #config.action_mailer.default_options = {
  #  from: Rails.application.secrets['mail']['from'],
  #  reply_to: Rails.application.secrets['mail']['reply_to']
  #}

  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV.fetch('SMTP_ADDRESS', 'smtp.mandrillapp.com'),
    port: ENV.fetch('SMTP_PORT', 587),
    enable_starttls_auto: true,
    user_name: ENV['SMTP_USERNAME'],
    password: ENV['SMTP_PASSWORD'],
    authentication: 'login',
    domain: ENV.fetch('SMTP_DOMAIN', 'localhost')
  }
end
