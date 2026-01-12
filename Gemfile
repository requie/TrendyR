source 'https://rubygems.org'

ruby '3.3.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 4.2.0'

# Ruby on Rails stylesheet engine for Sass
# Modern alternative to sass-rails
gem 'sassc-rails', '~> 2.1'

# Slim templates generator for Rails
# https://github.com/slim-template/slim-rails
gem 'slim-rails', '~> 3.6'

# Use Puma as the app server (modern replacement for Unicorn)
# https://github.com/puma/puma
gem 'puma', '~> 6.4'

# Brings Rails named routes to javascript
# https://github.com/railsware/js-routes
gem 'js-routes', '~> 2.2'

# Gem provides a helper asset_path in javascript.
# https://github.com/kavkaz/js_assets
gem 'js_assets', '~> 0.0.9'

# Modern Rails has native foreign key support, foreigner is deprecated

# Minimal authorization through OO design and pure Ruby classes
# https://github.com/varvet/pundit
gem 'pundit', '~> 2.3'

# A Ruby gem for on-the-fly processing - suitable for image uploading in Rails
# https://github.com/markevans/dragonfly
gem 'dragonfly', '~> 1.4'

# Decorators/View-Models for Rails Applications
# https://github.com/drapergem/draper
gem 'draper', '~> 4.0'

# Authentication & Authorization
gem 'devise', '~> 4.9'
gem 'omniauth', '~> 2.1'
gem 'omniauth-twitter', '~> 1.4'
gem 'omniauth-facebook', '~> 9.0'
gem 'omniauth-google-oauth2', '~> 1.1'
gem 'omniauth-rails_csrf_protection', '~> 1.0' # Required for OmniAuth 2.x

# Forms and UI
gem 'simple_form', '~> 5.3'
gem 'simple-navigation', '~> 4.4'
gem 'kaminari', '~> 1.2'

# jQuery and JavaScript
gem 'jquery-rails', '~> 4.6'
gem 'jbuilder', '~> 2.11'
gem 'gon', '~> 6.4'
gem 'tinymce-rails', '~> 6.8'

# Search and filtering
gem 'ransack', '~> 4.1'
gem 'taglib-ruby', '~> 1.1'

# Messaging
gem 'mailboxer', '~> 0.15'

# Background jobs
gem 'sidekiq', '~> 7.2'

# Elasticsearch
gem 'chewy', '~> 7.6'

# Process management
gem 'foreman'

# Payments
gem 'stripe', '~> 10.0'

# Comments
gem 'acts_as_commentable', '~> 4.0'

# Multi-step forms
gem 'wicked', '~> 2.0'

# Modern Rails dependencies
gem 'sprockets-rails', '~> 3.4'
gem 'importmap-rails', '~> 2.0'
gem 'turbo-rails', '~> 2.0'
gem 'stimulus-rails', '~> 1.3'

group :development do
  # Spring speeds up development by keeping your application running in the background.
  # https://github.com/rails/spring
  gem 'spring'

  # MailCatcher runs a super simple SMTP server which catches any message sent to it to display in a web interface
  # Note: mailcatcher should be installed globally, not in Gemfile for modern Rails
  # gem 'mailcatcher'

  # Rails Panel support
  gem 'meta_request'

  # A Ruby static code analyzer, based on the community Ruby style guide.
  # https://github.com/rubocop/rubocop
  gem 'rubocop', '~> 1.59', require: false
  gem 'rubocop-rails', '~> 2.23', require: false

  # A static analysis security vulnerability scanner for Ruby on Rails applications
  # https://github.com/presidentbeef/brakeman
  gem 'brakeman', '~> 6.1', require: false

  # Better Errors replaces the standard Rails error page with a much better and more useful error page
  # https://github.com/BetterErrors/better_errors
  gem 'better_errors', '~> 2.10'
  gem 'binding_of_caller', '~> 1.0'

  # Debugging
  gem 'pry-rails'
  gem 'debug', '~> 1.9'

  # Deployment
  # https://github.com/capistrano/capistrano
  gem 'capistrano', '~> 3.18'
  gem 'capistrano-rails', '~> 1.6'
  gem 'capistrano-rvm', '~> 0.1'
  gem 'capistrano3-puma', '~> 6.0'
end

group :development, :production do
  # Use PostgreSQL as a primary database engine
  gem 'pg', '~> 1.5'
end

group :development, :test do
  gem 'faker', '~> 3.2'
  gem 'rspec-rails', '~> 6.1'
  gem 'factory_bot_rails', '~> 6.4'
end
