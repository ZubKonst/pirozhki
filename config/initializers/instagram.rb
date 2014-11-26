require 'yaml'

instagram_configs = YAML.load_file("#{APP_ROOT}/config/variables/instagram.yml")
instagram_config = instagram_configs[APP_ENV]

Instagram.configure do |config|
  config.proxy     = instagram_config[:proxy]
  config.client_id = instagram_config[:client_id]
  config.client_secret = instagram_config[:client_secret]
end
