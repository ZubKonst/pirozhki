require_relative '../test_helper'
require_relative '../helpers/fake_instagram_response'
require_relative 'test_base_builder'

class TestLocationBuilder < Minitest::Test
  include TestBaseBuilder
  def builder; LocationBuilder end

  def setup
    DatabaseCleaner.start
    @collection_data = FakeInstagramResponse.new.all_with_named_location.map { |t| t['location'] }
    @sample_data = @collection_data.sample
  end

  def teardown
    DatabaseCleaner.clean
  end
end