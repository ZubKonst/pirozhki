require_relative '../config/initializers/env'

database_configs = YAML.load_file(File.join(File.dirname(__FILE__), '../config/variables/database.yml'))
database_config = database_configs[RUBY_ENV]
ActiveRecord::Base.establish_connection(database_config)

ActiveRecord::Migration.verbose = true

db_path = File.expand_path(File.join(File.dirname(__FILE__))).to_s

ActiveRecord::Migrator.migrate("#{db_path}/migrate", ENV['VERSION'] ? ENV['VERSION'].to_i : nil)

File.open("#{db_path}/schema.rb", 'w') do |schema_file|
  ActiveRecord::SchemaDumper.dump ActiveRecord::Base.connection, schema_file
end
