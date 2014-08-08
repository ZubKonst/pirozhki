database_configs = YAML.load_file(File.join(File.dirname(__FILE__), '../variables/database.yml'))
database_config = database_configs[RUBY_ENV]

connections = ActiveRecord::Base.establish_connection(database_config)
ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = (RUBY_ENV == 'development') ? 0 : 1
connections.connection.execute('SELECT 1')

