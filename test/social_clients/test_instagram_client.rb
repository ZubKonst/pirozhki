require_relative '../test_helper'

class TestInstagramClient < Minitest::Test

  def setup
    @instagram_client = InstagramClient.new
    @instagram_gem = Minitest::Mock.new
  end

  def test_geo_values
    client_params = [ 7.40, 33.33 ]
    instagram_gem_params = [
      7.40, 33.33,
      { distance: 5000, count: 100, min_timestamp: nil, max_timestamp: nil }
    ]
    verify_search_by_location client_params, instagram_gem_params
  end

  def test_geo_and_time_values
    client_params = [ 65.4321, 77.7, {min_time: 123_456, max_time: 1_400_000_000}  ]
    instagram_gem_params = [
      65.4321, 77.7,
      { distance: 5000, count: 100, min_timestamp: 123_456, max_timestamp: 1_400_000_000 }
    ]
    verify_search_by_location client_params, instagram_gem_params
  end

  def test_geo_and_dist_and_count_values
    client_params = [ 22, 11.11, {dist: 4000, count: 50}  ]
    instagram_gem_params = [
      22, 11.11,
      { distance: 4000, count: 50, min_timestamp: nil, max_timestamp: nil }
    ]
    verify_search_by_location client_params, instagram_gem_params
  end

  def test_hashtag_value
    client_params = [ 'Omsk' ]
    instagram_gem_params = [
      'Omsk',
      { count: 100, min_tag_id: nil, max_tag_id: nil }
    ]
    verify_search_by_hashtag client_params, instagram_gem_params
  end

  def test_hashtag_and_tag_ids_value
    client_params = [ 'Omsk', min_tag_id: 100, max_tag_id: 200 ]
    instagram_gem_params = [
      'Omsk',
      { count: 100, min_tag_id: 100, max_tag_id: 200 }
    ]
    verify_search_by_hashtag client_params, instagram_gem_params
  end

  private

  def verify_search_by_hashtag client_params, instagram_gem_params
    verify_instagram_gem_call *[
      :search_by_hashtag, client_params,
      :tag_recent_media, instagram_gem_params
    ]
  end

  def verify_search_by_location client_params, instagram_gem_params
    verify_instagram_gem_call *[
      :search_by_location, client_params,
      :media_search, instagram_gem_params
    ]
  end

  def verify_instagram_gem_call client_method, client_params, instagram_gem_method, instagram_gem_params
    Instagram.stub :client, @instagram_gem do
      @instagram_gem.expect instagram_gem_method, [], instagram_gem_params
      @instagram_client.public_send client_method, *client_params
      @instagram_gem.verify
    end
  end
end