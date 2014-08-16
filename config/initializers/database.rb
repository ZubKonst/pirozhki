database_configs = YAML.load_file(File.join(File.dirname(__FILE__), '../variables/database.yml'))
database_config = database_configs[RUBY_ENV]

connections = ActiveRecord::Base.establish_connection(database_config)
if RUBY_ENV == 'development'
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Base.logger.level = 0
end
connections.connection.execute('SELECT 1')

