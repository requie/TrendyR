source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.7'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

gem 'sass-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'

# Brings Rails named routes to javascript
# https://github.com/railsware/js-routes
gem 'js-routes'
# Gem provides a helper asset_path in javascript.
# https://github.com/kavkaz/js_assets
gem 'js_assets', '~> 0.0'

# Adds foreign key helpers to migrations and correctly dumps foreign keys to schema.rb
# https://github.com/matthuhiggins/foreigner
gem 'foreigner'

gem 'rails_config'

group :development do
  # Spring speeds up development by keeping your application running in the background.
  # https://github.com/rails/spring
  gem 'spring'
  # MailCatcher runs a super simple SMTP server which catches any message sent to it to display in a web interface
  # https://github.com/sj26/mailcatcher
  gem 'mailcatcher'
  # Extract from RailsPanel
  # https://github.com/qqshfox/meta_request
  gem 'meta_request', '~> 0.3.4'
  # A Ruby static code analyzer, based on the community Ruby style guide.
  # https://github.com/bbatsov/rubocop
  gem 'rubocop', require: false
  # Annotate ActiveRecord models as a gem
  # https://github.com/ctran/annotate_models
  gem 'annotate'
  # Automate the bundle/migration tedium of Rails with Git hooks
  # https://github.com/tpope/hookup
  gem 'hookup'
  # A static analysis security vulnerability scanner for Ruby on Rails applications
  # https://github.com/presidentbeef/brakeman
  gem 'brakeman', require: false
end

group :development, :production do
  # Use PostgreSQL as a primary database engine
  gem 'pg', '~> 0.17.1'
end
