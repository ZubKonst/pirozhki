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
    verify_instagram_gem_call client_params, instagram_gem_params
  end

  def test_geo_and_time_values
    client_params = [ 65.4321, 77.7, {min_time: 123_456, max_time: 1_400_000_000}  ]
    instagram_gem_params = [
      65.4321, 77.7,
      { distance: 5000, count: 100, min_timestamp: 123_456, max_timestamp: 1_400_000_000 }
    ]
    verify_instagram_gem_call client_params, instagram_gem_params
  end

  def test_geo_and_dist_and_count_values
    client_params = [ 22, 11.11, {dist: 4000, count: 50}  ]
    instagram_gem_params = [
      22, 11.11,
      { distance: 4000, count: 50, min_timestamp: nil, max_timestamp: nil }
    ]
    verify_instagram_gem_call client_params, instagram_gem_params
  end

  private

  def verify_instagram_gem_call client_params, instagram_gem_params
    @instagram_client.stub :instagram, @instagram_gem do
      @instagram_gem.expect :media_search, [], instagram_gem_params
      @instagram_client.media_search *client_params
      @instagram_gem.verify
    end
  end
end