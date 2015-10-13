require_relative '../test_helper'

class TestInstagramLoader < Minitest::Test

  def setup
    DatabaseCleaner.start
    @source = Source::Hashtag.create! tag_name: 'Omsk'
    @instagram_loader = InstagramLoader.new @source
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_filter_results
    raw_posts = Minitest::Mock.new
    raw_posts.expect :select_with_location!, raw_posts
    raw_posts.expect :select_new_posts!, raw_posts
    @source.stub :load_posts, raw_posts do
      @instagram_loader.get_posts only_not_persisted: true, only_with_location: true
    end
    raw_posts.verify
  end

  def test_not_filter_results
    raw_posts = Minitest::Mock.new
    @source.stub :load_posts, raw_posts do
      @instagram_loader.get_posts only_not_persisted: false, only_with_location: false
    end
    raw_posts.verify
  end

  def test_calls_instagram_client
    @instagram_client = Minitest::Mock.new
    @instagram_client.expect :search_by_hashtag, [], ['Omsk', {}]
    InstagramClient.stub :new, @instagram_client do
      @instagram_loader.get_posts
    end
    @instagram_client.verify
  end

  def test_max_time
    @instagram_client = Minitest::Mock.new
    @instagram_client.expect :search_by_hashtag, [], ['Omsk', max_time: 1_000_000 - 1.day]
    InstagramClient.stub :new, @instagram_client do
      stubbed_time = Time.at 1_000_000
      Time.stub :now, stubbed_time do
        Settings.instagram.stub :request_delay, 1.day do
          @instagram_loader.get_posts
        end
      end
    end
    @instagram_client.verify
  end
end
