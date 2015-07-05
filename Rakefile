require 'yaml'

require_relative 'config/initializers/env'
require_relative 'app'

## Test tasks ##
require 'rake'
require 'rake/testtask'
Rake::TestTask.new do |t|
  t.test_files = Dir.glob 'test/**/test_*.rb'
end
task :default => :test
##############


## DB tasks ##
require_relative 'lib/seeder'
require 'active_record_migrations'
ActiveRecordMigrations.configure do |c|
  c.database_configuration = YAML.load_file "#{APP_ROOT}/config/variables/database.yml"
  c.schema_format = :ruby
  c.yaml_config = 'config/variables/database.yml'
  c.environment = APP_ENV
  c.db_dir = 'db'
  c.migrations_paths = ['db/migrate']
  c.seed_loader = Seeder.new "#{APP_ROOT}/db/seed.rb"
end
ActiveRecordMigrations.load_tasks
