if Settings.has_key? 'rollbar' and Settings.rollbar.enabled
  require 'rollbar'

  Rollbar.configure do |config|
    config.access_token = Settings.rollbar.access_token
    config.environment = APP_ENV
    config.framework = "Sidekiq: #{::Sidekiq::VERSION}"
    config.root = APP_ROOT
    config.use_sidekiq
  end
end
