if Settings.has_key? 'rollbar' and Settings.rollbar.enabled
  require 'rollbar'

  Rollbar.configure do |config|
    config.access_token = Settings.rollbar.access_token
    config.use_sidekiq
  end
end
