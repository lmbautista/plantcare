# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PlantcareApi
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
    config.i18n.available_locales = %i(en es)
    config.cache_store = :memory_store, { size: 64.megabytes, expires_in: 5.minutes }

    config.hosts << "dev.yourplantcare.com"
    config.hosts << "yourplantcare.com"
    config.hosts << "www.yourplantcare.com"
    config.hosts << "0.0.0.0"
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
    # config.web_console.whitelisted_ips = '172.19.0.0/16' # rubocop:disable Naming/InclusiveLanguage

    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true
  end
end
