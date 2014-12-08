if defined?(IRB) && APP_ENV != 'test'
  AwesomePrint.irb!

  redis_config = YAML.load_file("#{APP_ROOT}/config/variables/redis.yml")[APP_ENV]
  raise "Empty redis_config for #{APP_ENV}" unless redis_config
  $redis = Redis.new(redis_config)

  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Base.logger.level = 0
  ActiveRecord::Base.connection.execute('SELECT 1')
end
