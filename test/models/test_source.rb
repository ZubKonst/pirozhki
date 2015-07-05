require_relative '../test_helper'

class TestSource < Minitest::Test

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_find_hashtag
    hashtag = Source::Hashtag.create! tag_name: 'Omsk'
    source = Source.find_source 'Source::Hashtag', hashtag.id
    assert_equal hashtag.attributes.to_a, source.attributes.to_a
  end

  def test_find_geo_point
    geo_point = Source::GeoPoint.create! lat: 54.983333, lng: 73.366667
    source = Source.find_source 'Source::GeoPoint', geo_point.id
    assert_equal geo_point.attributes.to_a, source.attributes.to_a.sort
  end

  def test_raise_if_source_unknown
    err = assert_raises RuntimeError do
      Source.find_source 'Source::Unknown', 666
    end
    assert_equal 'Unknown source type Source::Unknown', err.message
  end

  def test_raise_if_id_invalid
    hashtag = Source::Hashtag.create! tag_name: 'Omsk'
    invalid_id = hashtag.id+1
    err = assert_raises ActiveRecord::RecordNotFound do
      Source.find_source 'Source::Hashtag', invalid_id
    end
    assert_equal "Couldn't find Source::Hashtag with 'id'=#{invalid_id}", err.message
  end

  def test_returns_all_sources
    hashtag   = Source::Hashtag.create! tag_name: 'Omsk'
    geo_point = Source::GeoPoint.create! lat: 54.983333, lng: 73.366667
    sources = Source.all_sources
    sources_ids = sources.map &:id
    assert_equal [hashtag.id, geo_point.id].sort, sources_ids.sort
  end

end
