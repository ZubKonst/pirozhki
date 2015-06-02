require_relative '../test_helper'
require_relative '../helpers/fake_instagram_response'
require_relative 'test_base_builder'

class TestTagBuilder < Minitest::Test
  include TestBaseBuilder
  def builder; TagBuilder end

  def setup
    DatabaseCleaner.start
    @collection_data = FakeInstagramResponse.new.all_with_tags.flat_map { |t| t['tags'] }
    @sample_data = @collection_data.sample
  end

  def teardown
    DatabaseCleaner.clean
  end
end