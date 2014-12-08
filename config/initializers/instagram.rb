require 'yaml'

instagram_config = Settings.instagram

Instagram.configure do |config|
  config.proxy         = instagram_config.proxy
  config.client_id     = instagram_config.client_id
  config.client_secret = instagram_config.client_secret
end
