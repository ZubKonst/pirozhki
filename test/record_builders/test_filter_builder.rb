require_relative '../test_helper'
require_relative '../helpers/fake_instagram_loader'
require_relative 'test_base_builder'

class TestFilterBuilder < Minitest::Test
  include TestBaseBuilder
  def builder; FilterBuilder end

  def setup
    DatabaseCleaner.start
    posts = FakeInstagramLoader.new.get_posts
    @collection_data = posts.map { |t| t['filter'] }
    @sample_data = @collection_data.sample
  end

  def teardown
    DatabaseCleaner.clean
  end
end