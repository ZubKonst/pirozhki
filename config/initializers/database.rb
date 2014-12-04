require 'yaml'

database_config =  YAML.load_file("#{APP_ROOT}/config/variables/database.yml")[APP_ENV]
raise "Empty database_config for #{APP_ENV}" unless database_config

ActiveRecord::Base.establish_connection(database_config)
