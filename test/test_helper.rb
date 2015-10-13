APP_ENV = ENV['APP_ENV'] || 'test'
ENV['APP_ENV'] = APP_ENV

## TestCoverage ##
if ENV['COVERAGE'] || ENV['TRAVIS']
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]
  SimpleCov.start do
    add_group 'Models', 'app/models'
    add_group 'RecordBuilders', 'app/record_builders'
    add_group 'Services', 'app/services'
    add_group 'SocialClients', 'app/social_clients'
    add_group 'Workers', 'app/workers'

    add_filter '/config/'
    add_filter '/test/'
  end
end
###################

## Requires ##
require 'minitest/autorun'
require_relative '../config/initializers/env'
require_relative '../app'
###################

## AwesomePrint ##
module Minitest::Assertions
  def mu_pp obj
    obj.awesome_inspect
  end
end
###################
