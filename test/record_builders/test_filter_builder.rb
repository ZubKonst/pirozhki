require_relative '../test_helper'
require_relative '../helpers/fake_instagram_response'
require_relative 'test_base_builder'

class TestFilterBuilder < Minitest::Test
  include TestBaseBuilder
  def builder; FilterBuilder end

  def setup
    DatabaseCleaner.start
    @collection_data = FakeInstagramResponse.new.all.map { |t| t['filter'] }
    @sample_data = @collection_data.sample
  end

  def teardown
    DatabaseCleaner.clean
  end
end