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
require_relative 'helpers/fake_instagram_response'
###################


RSpec.configure do |config|

  ## DatabaseCleaner ##
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
    DatabaseCleaner.strategy = :transaction
  end
  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
  ###################

end
