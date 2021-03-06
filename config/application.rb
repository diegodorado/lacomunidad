require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require *Rails.groups(:assets => %w(development test))
end

module Lacomunidad
  class Application < Rails::Application
    # config.time_zone = 'Central Time (US & Canada)'
    config.i18n.default_locale = :es
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.assets.enabled = true
    config.assets.version = '1.0'
    #config.action_mailer.default_url_options = { :host => 'localhost:3000' }

    config.generators.stylesheets = false
    config.generators.javascripts = false

    config.action_mailer.default_url_options = { :host => 'lacomunidad.org.ar' }
    ActionMailer::Base.smtp_settings = {
      :address        => "smtp.sendgrid.net",
      :port           => "25",
      :authentication => :plain,
      :user_name      => ENV['SENDGRID_USERNAME'],
      :password       => ENV['SENDGRID_PASSWORD'],
      :domain         => ENV['SENDGRID_DOMAIN']
    }
    
  end
end
