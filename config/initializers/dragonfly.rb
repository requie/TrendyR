require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret '15b022eb5f3438cdcce818571a18517bb3be0f48584232ecdc4d53e807de00db'

  url_format '/media/:job/:name'

  datastore :file,
            root_path: Rails.root.join('public/system/dragonfly', Rails.env),
            server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
