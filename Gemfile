source 'https://rubygems.org'

# rails parts
gem 'activerecord',  '4.1.8', require: 'active_record'
gem 'activesupport', '4.1.8', require: %w[ active_support/concern ]

# databases
gem 'active_record_migrations', require: false
gem 'pg'
gem 'hiredis'
gem 'redis', require:  %w[ redis redis/connection/hiredis ]
gem 'redis-namespace'

# export
gem 'logstash-logger'

# support
gem 'awesome_print'
gem 'oj'
gem 'rake'

# social networks
gem 'instagram'

# web
gem 'puma'

# workflow
gem 'settingslogic'
gem 'sidekiq'
gem 'sidekiq-throttler'
gem 'sidekiq-unique-jobs'
gem 'sidetiq'
gem 'god'

# gem 'airbrake'
# gem 'newrelic'


group :development do
  gem 'capistrano', '~> 2.15.5'
  gem 'capistrano_colors'
  gem 'rvm-capistrano'

  gem 'foreman'
end

group :test do
  gem 'rspec'
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'coveralls', require: false
  gem 'mutant', require: false
  gem 'mutant-rspec', require: false
end

group :help do
  gem 'pr_geohash'
end
