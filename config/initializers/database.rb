require 'yaml'

database_configs = YAML.load_file "#{APP_ROOT}/config/variables/database.yml"
database_config  = database_configs[APP_ENV]
raise "Empty database_config for #{APP_ENV}" unless database_config

ActiveRecord::Base.establish_connection database_config
unless APP_ENV == 'test'
  ActiveRecord::Base.logger = Logger.new STDOUT
end
