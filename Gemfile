source 'https://rubygems.org'

# rails parts
gem 'activerecord',  '4.2.4', require: 'active_record'
gem 'activesupport', '4.2.4',
    require: %w[ active_support/core_ext/numeric/time active_support/concern ]

# databases
gem 'active_record_migrations', require: false
gem 'pg'
gem 'hiredis'
gem 'redis', require: %w[ redis redis/connection/hiredis ]
gem 'redis-namespace'

# export
gem 'logstash-logger', require: false

# support
gem 'awesome_print'
gem 'json'
gem 'rake'
gem 'newrelic_rpm', require: false
gem 'rollbar', require: false

# social networks
gem 'instagram'

# web
gem 'puma'

# workflow
gem 'settingslogic'
gem 'sidekiq', '3.4.2' # https://github.com/tobiassvn/sidetiq/issues/140
gem 'sinatra'
gem 'sidekiq-throttler'
gem 'sidekiq-unique-jobs'
gem 'sidetiq'
gem 'sidekiq-statistic'

group :development do
  gem 'foreman'
end

group :test do
  gem 'minitest'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'coveralls', require: false
end

group :help do
  gem 'geokit'
end
