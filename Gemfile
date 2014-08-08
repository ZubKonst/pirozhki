source 'https://rubygems.org'

# rails parts
gem 'activerecord',  '4.1.4', require: 'active_record'
gem 'activesupport', '4.1.4', require: 'active_support/core_ext/numeric/time'

# databases
gem 'pg'
gem 'hiredis'
gem 'redis', require:  %w[ redis redis/connection/hiredis ]
gem 'redis-namespace', git: 'https://github.com/resque/redis-namespace.git'

# export
gem 'logstash-logger'

# support
gem 'awesome_print'
gem 'oj'

# social networks
gem 'instagram'

# web
gem 'puma'

# workflow
gem 'sidekiq'
gem 'sidekiq-benchmark'
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
  gem 'minitest'
end

group :help do
  gem 'pr_geohash'
end
