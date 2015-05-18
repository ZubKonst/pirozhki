require_relative '../test_helper'
require_relative '../helpers/fake_instagram_response'

class TestPost < Minitest::Test

  def setup
    DatabaseCleaner.start
    geo_point = GeoPoint.create! lat: rand*100, lng: rand*100
    instagram_response = FakeInstagramResponse.new geo_point.id
    @post_data = instagram_response.sample_with_meta
    @post = InstagramRecorder.create_from_hash @post_data
  end

  def teardown
    DatabaseCleaner.clean
  end

  ## Structure validation ##
  def test_export_data_structure
    required_fields =
      %w[ post_id post_instagram_id post_created_time post_content_type post_caption
           post_tags post_tags_count post_tagged_users_count post_likes_count post_comments_count
           user_id user_instagram_id user_nick_name
           geo_point_id geo_point_long_lat
           location_id location_instagram_id location_name location_long_lat
           filter_id filter_name ]

    export_data = @post.export_data
    assert_equal required_fields.sort, export_data.keys.sort
  end

  ## Content validation ##
  def test_export_data_counters
    expected_counters = {
      'post_tags_count'         => @post_data['tags'].count,
      'post_likes_count'        => @post_data['likes']['count'],
      'post_comments_count'     => @post_data['comments']['count'],
      'post_tagged_users_count' => @post_data['users_in_photo'].count,
    }

    export_data = @post.export_data
    expected_counters.each do |counter, value|
      assert_equal value, export_data[counter]
    end
  end

  def test_export_data_tags
    export_data = @post.export_data
    assert_equal @post_data['tags'].sort, export_data['post_tags'].sort
  end
end