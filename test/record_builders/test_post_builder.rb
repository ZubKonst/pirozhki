require_relative '../test_helper'
require_relative '../helpers/fake_instagram_response'
require_relative 'test_base_builder'

class TestPostBuilder < Minitest::Test
  include TestBaseBuilder
  def builder; PostBuilder end

  def setup
    DatabaseCleaner.start
    @collection_data = FakeInstagramResponse.new.all_with_meta
    @collection_data.each { |post_data| add_fake_records_info post_data }
    @sample_data = @collection_data.sample
  end

  def teardown
    DatabaseCleaner.clean
  end

  private

  def add_fake_records_info post_data
    post_data['meta'] ||= {}
    post_data['meta']['records'] =
      {
        'user_id'     => rand(100),
        'tag_ids'     => [],
        'filter_id'   => rand(100),
        'location_id' => rand(100),
        'tagged_user_ids' => [],
      }
    post_data
  end

end
