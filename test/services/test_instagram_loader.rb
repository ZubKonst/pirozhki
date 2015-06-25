require_relative '../test_helper'

class TestInstagramLoader < Minitest::Test

  def setup
    @source = Minitest::Mock.new
    @instagram_loader = InstagramLoader.new @source
  end

  def test_calls_load_posts
    @source.expect :load_posts, [], [{}]
    @instagram_loader.get_posts
    @source.verify
  end

  def test_adds_max_time
    Time.stub :now, Time.at(1_000) do
      Settings.instagram.stub :request_delay, 1.day do
        @source.expect :load_posts, [], [{max_time: 1_000 - 1.day}]
        @instagram_loader.get_posts
        @source.verify
      end
    end
  end

  def test_adds_meta_data
    @post = {}
    @source.expect :id, 6
    @source.expect :type_as_source, 'Hashtag'

    Time.stub :now, Time.at(1_000) do
      @instagram_loader.stub :load_posts, [@post] do
        @instagram_loader.get_posts
      end
    end

    assert_equal 6, @post['meta']['source_id']
    assert_equal 'Hashtag', @post['meta']['source_type']
    assert_equal 1_000, @post['meta']['request_at']
    @source.verify
  end

end
