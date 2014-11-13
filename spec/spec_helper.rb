ENV['RUBY_ENV'] ||= 'test'

## TestCoverage ##
require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_group 'Models', 'app/models'
  add_group 'RecordBuilders', 'app/record_builders'
  add_group 'SocialClients', 'app/social_clients'
  add_group 'Workers', 'app/workers'
end
###################



## Requires ##
require_relative '../app'
require 'minitest/pride'
require 'minitest/autorun'
require 'minitest/benchmark'
require_relative 'helpers/fake_instagram_response'
require_relative 'helpers/match_array'
###################


## AwesomePrint ##
module Minitest::Assertions
  ##
  # This returns a human-readable version of +obj+. By default
  # #inspect is called. You can override this to use #pretty_print
  # if you want.

  def mu_pp obj
    obj.awesome_inspect
  end
end
###################


## DatabaseCleaner ##
DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :transaction
class MiniTest::Spec
  before do
    DatabaseCleaner.start
  end

  after do
    DatabaseCleaner.clean
  end
end
###################
