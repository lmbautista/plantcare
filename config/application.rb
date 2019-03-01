require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Plantcare
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :es
    config.cache_store         = :memory_store, { size: 1024.megabytes, expires_in: 30.minutes }
    # Lograge config
    # config.lograge.enabled        = true
    # config.lograge.formatter      = Lograge::Formatters::Logstash.new
    # config.lograge.logger         = ActiveSupport::Logger.new(STDOUT)
    # config.lograge.custom_options = lambda do |event|
    #   {
    #     request_ip: event.payload[:request_ip]
    #   }
    # end

    # Allow IPs to render log to STDOUT for logstash
    # config.web_console.whitelisted_ips = '172.19.0.0/16'

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
  end
end
