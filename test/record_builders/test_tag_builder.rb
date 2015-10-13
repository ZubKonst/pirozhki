require_relative '../test_helper'
require_relative '../helpers/fake_instagram_loader'
require_relative 'test_base_builder'

class TestTagBuilder < Minitest::Test
  include TestBaseBuilder
  def builder; TagBuilder end

  def setup
    DatabaseCleaner.start
    posts = FakeInstagramLoader.new.get_posts
    posts.select_with_tags!
    @collection_data = posts.flat_map { |t| t['tags'] }
    @sample_data = @collection_data.sample
  end

  def teardown
    DatabaseCleaner.clean
  end
end