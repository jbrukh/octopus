require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module Ruby
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # autoload everything in lib
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # required to get handlebars assets compiling
    config.railties_order = [:main_app, :all, Ember::Rails::Engine]

    # additional asset to precompile
    config.assets.precompile += [
        # octopus assets
        'octopus.js', 'octopus/octopus.css',

        # active admin assets
        'active_admin.css', 'active_admin/print.css', 'active_admin.js']

    config.middleware.use "NoWww"
  end
end
