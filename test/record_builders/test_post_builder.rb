require_relative '../test_helper'
require_relative '../helpers/fake_instagram_response'
require_relative 'test_base_builder'

class TestPostBuilder < Minitest::Test
  include TestBaseBuilder
  def builder; PostBuilder end

  def setup
    DatabaseCleaner.start
    geo_point = GeoPoint.create! lat: rand*100, lng: rand*100
    instagram_response = FakeInstagramResponse.new geo_point.id
    @collection_data = instagram_response.all_with_meta
    @sample_data = @collection_data.sample
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_select_new_posts
    created_posts, not_created_posts = randomly_split @collection_data
    created_posts.each do |post_data|
      PostBuilder.find_or_create! post_data
    end

    not_existed_posts = PostBuilder.not_existed @collection_data

    not_existed_posts_ids  = not_existed_posts.map { |post_data| post_data['id'] }
    expected_new_posts_ids = not_created_posts.map { |post_data| post_data['id'] }
    assert_equal expected_new_posts_ids.sort, not_existed_posts_ids.sort
  end

  private

  def randomly_split arr
    arr.group_by { rand 2 } .values
  end
end