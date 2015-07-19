if $0 == 'irb'
  AwesomePrint.irb!

  redis_configs = YAML.load_file "#{APP_ROOT}/config/variables/redis.yml"
  redis_config = redis_configs[APP_ENV]
  unless redis_config
    raise "Empty redis_config for #{APP_ENV}"
  end
  $redis = Redis.new redis_config

  ActiveRecord::Base.logger = Logger.new STDOUT
  ActiveRecord::Base.logger.level = 0
  ActiveRecord::Base.connection.execute 'SELECT 1'
end
