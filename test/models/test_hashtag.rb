require_relative '../test_helper'

class TestHashtag < Minitest::Test

  def setup
    DatabaseCleaner.start
    @hashtag = Source::Hashtag.create! tag_name: 'Omsk'
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_type_as_source
    assert_equal 'Source::Hashtag', @hashtag.type_as_source
  end

  def test_load_posts
    @instagram_client = Minitest::Mock.new
    @instagram_client.expect :search_by_hashtag, true, ['Omsk', {min_tag_id: 1000}]

    InstagramClient.stub :new, @instagram_client do
      @hashtag.load_posts min_tag_id: 1000
    end

    @instagram_client.verify
  end
end
