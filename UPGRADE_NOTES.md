# Rails 7.1 & Ruby 3.3 Upgrade Notes

This document outlines the comprehensive modernization of the TrendyR codebase from Rails 4.1.7 / Ruby 2.1.5 to Rails 7.1 / Ruby 3.3.6.

## Overview of Changes

### Ruby Version
- **Before**: Ruby 2.1.5 (Released 2014)
- **After**: Ruby 3.3.6 (Released 2024)

### Rails Version
- **Before**: Rails 4.1.7 (Released 2014)
- **After**: Rails 7.1.x (Latest stable)

### Application Server
- **Before**: Unicorn 4.8.3
- **After**: Puma 6.4 (modern, threaded server)

## Major Dependency Updates

| Gem | Old Version | New Version | Breaking Changes |
|-----|-------------|-------------|------------------|
| rails | 4.1.7 | ~> 7.1.0 | Major - see below |
| devise | 3.4.1 | ~> 4.9 | Parameter sanitizer API changed |
| omniauth | 1.2.2 | ~> 2.1 | Requires CSRF protection |
| pundit | 0.3.0 | ~> 2.3 | Minor API changes |
| sidekiq | 3.3.4 | ~> 7.2 | Configuration changes |
| pg | 0.17.1 | ~> 1.5 | Minor API updates |
| jquery-rails | 3.1.2 | ~> 4.6 | Security updates |
| stripe | 1.27.2 | ~> 10.0 | Major API changes |
| draper | 1.4.0 | ~> 4.0 | Rails 7 compatible |
| chewy | 0.8.1 | ~> 8.0 | Elasticsearch client updates |
| kaminari | 0.16.1 | ~> 1.2 | Modern pagination |
| simple_form | 3.1.0 | ~> 5.3 | Rails 7 compatible |

### Removed Dependencies
- **foreigner** - Rails now has native foreign key support
- **sass-rails** - Replaced with sassc-rails (LibSass)
- **unicorn** - Replaced with Puma

### New Dependencies
- **omniauth-rails_csrf_protection** - Required for OmniAuth 2.x security
- **turbo-rails** - Hotwire/Turbo support
- **stimulus-rails** - Modern JavaScript framework
- **importmap-rails** - JavaScript module management
- **rubocop-rails** - Rails-specific Ruby linting
- **debug** - Modern debugging tools
- **binding_of_caller** - Enhanced error pages
- **capistrano3-puma** - Puma deployment support
- **rspec-rails** - Modern testing framework
- **factory_bot_rails** - Test fixtures

## Code Changes Made

### 1. Deprecated Devise API
**File**: `app/controllers/application_controller.rb`

```ruby
# OLD (deprecated)
devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :role_ids]

# NEW (Rails 7)
devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role_ids])
```

### 2. Deprecated Dynamic Finders
**File**: `db/seeds.rb`
```ruby
# OLD
User.find_by_email(email)

# NEW
User.find_by(email: email)
```

**File**: `app/services/booking_refund_service.rb`
```ruby
# OLD
Order.find_by_purchasable_id(booking.id)

# NEW
Order.find_by(purchasable_id: booking.id)
```

### 3. Configuration Updates

#### config/application.rb
```ruby
# OLD
require File.expand_path('../boot', __FILE__)
config.autoload_paths += Dir[...]

# NEW
require_relative 'boot'
# Rails 7 uses Zeitwerk for autoloading
config.eager_load_paths << Rails.root.join('app', 'navigation_renderers')
config.eager_load_paths << Rails.root.join('app', 'services')
```

#### config/environments/production.rb
```ruby
# OLD
config.serve_static_assets = false

# NEW
config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
```

#### config/environments/development.rb
- Removed hardcoded SMTP credentials
- Moved to environment variables (see .env.example)
- Added `config.public_file_server.enabled = true`

### 4. Modern Ruby Syntax
Updated `__FILE__` and `File.expand_path` patterns to use `__dir__` and `require_relative` throughout configuration files.

## New Configuration Files

### 1. config/puma.rb
Created new Puma configuration to replace Unicorn. Features:
- Thread pool configuration
- Worker process management
- Unix socket binding
- Logging configuration
- Preloading for better memory usage

### 2. .env.example
Created environment variable template for:
- Database configuration
- SMTP settings (moved from hardcoded)
- OAuth provider credentials
- Stripe API keys
- Redis/Elasticsearch URLs

## Breaking Changes & Required Actions

### 1. OmniAuth 2.x Security
**Action Required**: OmniAuth 2.x requires CSRF protection. Added `omniauth-rails_csrf_protection` gem.

**Migration Steps**:
- Update all OmniAuth callback routes
- Ensure forms use POST instead of GET for authentication
- Test all OAuth providers (Twitter, Facebook, Google)

### 2. Stripe API v10
**Action Required**: Stripe API has major changes from v1.x to v10.x.

**Migration Steps**:
- Review `app/services/booking_refund_service.rb` and other Stripe integrations
- Update API calls to use new Stripe gem syntax
- Test payment and refund workflows
- Update webhook handling if applicable

### 3. Asset Pipeline Changes
**Action Required**: Asset pipeline has evolved significantly.

**Migration Steps**:
- Test asset compilation: `rails assets:precompile`
- Verify JavaScript and CSS are loading correctly
- Consider migrating to importmap-rails for modern JS
- Update any custom asset pipeline configurations

### 4. Zeitwerk Autoloader
**Action Required**: Rails 7 uses Zeitwerk autoloader by default.

**Migration Steps**:
- Ensure file names match class names (e.g., `user_profile.rb` → `class UserProfile`)
- Check that all `app/` subdirectories follow naming conventions
- Run `rails zeitwerk:check` to validate autoloading

### 5. Secret Management
**Action Required**: Rails 7 prefers `credentials` over `secrets`.

**Current State**: Code still references `Rails.application.secrets`

**Migration Steps**:
1. Run `rails credentials:edit` to create encrypted credentials
2. Migrate secrets from `config/secrets.yml` to credentials
3. Update code to use `Rails.application.credentials` instead
4. Remove `config/secrets.yml` after migration

### 6. Database Migrations
**Action Required**: Foreign key support is now native.

**Migration Steps**:
- Remove `foreigner` gem references if any
- Update migrations to use Rails native `add_foreign_key`
- Test migrations: `rails db:migrate:status`

### 7. Sidekiq Configuration
**Action Required**: Sidekiq 7.x has configuration changes.

**Migration Steps**:
- Review `config/sidekiq.yml`
- Update worker classes if needed
- Test background job processing
- Update Sidekiq web UI mounting in routes

### 8. Elasticsearch / Chewy
**Action Required**: Chewy 8.x requires Elasticsearch client updates.

**Migration Steps**:
- Review `app/chewy/` index definitions
- Update Elasticsearch connection configuration
- Reindex all searchable models
- Test search functionality

## Testing Checklist

### Before Deploying
- [ ] Run `bundle install` successfully
- [ ] Run `rails zeitwerk:check` without errors
- [ ] Run `rails db:migrate:status` to check migrations
- [ ] Run `rails assets:precompile` successfully
- [ ] Test authentication (Devise)
- [ ] Test OAuth login (Twitter, Facebook, Google)
- [ ] Test payment processing (Stripe)
- [ ] Test background jobs (Sidekiq)
- [ ] Test search functionality (Elasticsearch)
- [ ] Test email sending
- [ ] Test file uploads (Dragonfly)
- [ ] Review and update all initializers
- [ ] Run security audit: `bundle audit`
- [ ] Run code quality check: `rubocop`
- [ ] Run security scan: `brakeman`

### Environment Setup
- [ ] Create `.env` from `.env.example`
- [ ] Configure all environment variables
- [ ] Set up Redis for Sidekiq
- [ ] Set up Elasticsearch
- [ ] Configure PostgreSQL
- [ ] Test with Puma instead of Unicorn

## Deployment Notes

### Development Environment
```bash
# Install dependencies
bundle install

# Set up database
rails db:create db:migrate db:seed

# Start services (using Foreman)
foreman start

# Or start individually
rails server  # Puma will start
sidekiq
```

### Production Deployment
1. Update deployment scripts to use Puma instead of Unicorn
2. Update systemd/init scripts if applicable
3. Configure Capistrano with `capistrano3-puma` gem
4. Update nginx configuration for Puma unix socket
5. Set all required environment variables
6. Run asset precompilation on deploy
7. Restart background workers

## Common Issues & Solutions

### Issue: Zeitwerk NameError
**Solution**: Ensure file names match class names exactly. Run `rails zeitwerk:check`.

### Issue: OmniAuth CSRF Error
**Solution**: Ensure `omniauth-rails_csrf_protection` gem is installed and forms use POST.

### Issue: Asset Not Found
**Solution**: Run `rails assets:precompile` and check `config/initializers/assets.rb`.

### Issue: Sidekiq Not Processing Jobs
**Solution**: Update Sidekiq configuration for version 7.x syntax.

### Issue: Stripe API Errors
**Solution**: Review Stripe gem v10 documentation and update API calls.

## Additional Resources

- [Rails 7.1 Release Notes](https://guides.rubyonrails.org/7_1_release_notes.html)
- [Rails Upgrade Guide](https://guides.rubyonrails.org/upgrading_ruby_on_rails.html)
- [Ruby 3.3 Release Notes](https://www.ruby-lang.org/en/news/2023/12/25/ruby-3-3-0-released/)
- [Puma Configuration](https://github.com/puma/puma#configuration)
- [OmniAuth 2.x Guide](https://github.com/omniauth/omniauth#getting-started)
- [Devise 4.x Guide](https://github.com/heartcombo/devise#getting-started)

## Security Improvements

This upgrade addresses multiple security vulnerabilities:
- Devise authentication security fixes
- OmniAuth CSRF protection
- Updated jQuery (XSS vulnerabilities)
- Modern TLS/SSL support in Ruby 3.3
- Updated gem dependencies with security patches

## Performance Improvements

- Puma threaded server (better performance than Unicorn)
- Ruby 3.3 performance improvements (JIT, YJIT)
- Modern Rails optimizations
- Zeitwerk autoloader (faster code loading)
- Updated database adapter (better PostgreSQL support)

## Rollback Plan

If issues occur:
1. Revert to previous branch
2. Restore Gemfile.lock backup
3. Restore database backup
4. Switch back to Unicorn if needed
5. Document issues encountered

## Next Steps

1. **Immediate**: Test all functionality in development
2. **Short-term**: Deploy to staging environment
3. **Medium-term**: Run comprehensive test suite
4. **Long-term**: Consider further modernization:
   - Migrate to Hotwire/Turbo fully
   - Replace jQuery with modern JavaScript
   - Update to latest Rails versions as released
   - Implement proper test coverage with RSpec

## Support & Questions

For questions about this upgrade:
- Review this document thoroughly
- Check the Rails upgrade guides
- Consult gem-specific documentation
- Test incrementally in development

---

**Upgrade Date**: 2026-01-12
**Performed By**: Automated modernization process
**Branch**: claude/modernize-codebase-A92mb
