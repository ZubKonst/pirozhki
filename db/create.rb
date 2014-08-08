require_relative '../config/initializers/env'

database_configs = YAML.load_file(File.join(File.dirname(__FILE__), '../config/variables/database.yml'))
database_config = database_configs[RUBY_ENV]

ActiveRecord::Base.establish_connection(database_config.merge('database' => 'postgres'))
ActiveRecord::Base.connection.create_database(database_config['database'])

connections = ActiveRecord::Base.establish_connection(database_config)
connections.connection.execute('SELECT 1')
