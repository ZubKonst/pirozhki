require_relative '../test_helper'

class TestGeoPoint < Minitest::Test

  def setup
    DatabaseCleaner.start
    @geo_point = GeoPoint.create! lat: 54.983333, lng: 73.366667
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_type_as_source
    assert_equal 'GeoPoint', @geo_point.type_as_source
  end

  def test_load_posts
    @instagram_client = Minitest::Mock.new
    @instagram_client.expect :search_by_location, true, [54.983333, 73.366667, {min_time: 1000}]
    InstagramClient.stub :new, @instagram_client do
      @geo_point.load_posts min_time: 1000
    end
    @instagram_client.verify
  end
end
