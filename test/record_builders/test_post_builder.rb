require_relative '../test_helper'
require_relative '../helpers/fake_instagram_loader'
require_relative 'test_base_builder'

class TestPostBuilder < Minitest::Test
  include TestBaseBuilder
  def builder; PostBuilder end

  def setup
    DatabaseCleaner.start
    posts = FakeInstagramLoader.new.get_posts
    @collection_data = posts.to_a.each { |post_data| add_fake_records_info post_data }
    @sample_data = @collection_data.sample
  end

  def teardown
    DatabaseCleaner.clean
  end

  private

  def add_fake_records_info post_data
    post_data['related_records'] = fake_records_info
    post_data
  end

  def fake_records_info
    data = {}
    data['user_id']         = rand 100
    data['tag_ids']         = []
    data['filter_id']       = rand 100
    data['location_id']     = rand 100
    data['tagged_user_ids'] = []
    data
  end

end
