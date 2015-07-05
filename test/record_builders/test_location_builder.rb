require_relative '../test_helper'
require_relative '../helpers/fake_instagram_loader'
require_relative 'test_base_builder'

class TestLocationBuilder < Minitest::Test
  include TestBaseBuilder
  def builder; LocationBuilder end

  def setup
    DatabaseCleaner.start
    posts = FakeInstagramLoader.new.get_posts.select_with_location
    @collection_data = posts.map { |t| t['location'] }
    @sample_data = @collection_data.sample
  end

  def teardown
    DatabaseCleaner.clean
  end
end