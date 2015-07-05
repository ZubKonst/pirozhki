require_relative '../test_helper'

class TestRawPosts < Minitest::Test
  def setup
    @source_id = 1
    @source_type = 'Source::Hashtag'
  end

  def test_source_info
    instagram_response = [{'id' => 1}, {'id' => 2}, {'id' => 3}]
    raw_posts = RawPosts.new @source_type, @source_id, instagram_response
    assert_equal instagram_response.count, raw_posts.count
    raw_posts.each do |raw_post|
      assert_equal @source_id,   raw_post['source']['id']
      assert_equal @source_type, raw_post['source']['type']
    end
  end

  def test_select_with_tags
    instagram_response = [
      {'id' => 1, 'tags' => %w[ Omsk Tomsk ]},
      {'id' => 2, 'tags' => %w[]},
      {'id' => 3, 'tags' => %w[ Toronto London ]},
    ]
    raw_posts = RawPosts.new @source_type, @source_id, instagram_response
    raw_posts = raw_posts.select_with_tags
    assert_equal [1, 3], raw_posts.map { |t| t['id'] }.sort
  end

  def test_select_with_location
    instagram_response = [
      {'id' => 1, 'location' => nil},
      {'id' => 2, 'location' => {'id' => 2}},
      {'id' => 3, 'location' => {'id' => 3, 'latitude' => 55.5, 'longitude' => 33.3}},
    ]
    raw_posts = RawPosts.new @source_type, @source_id, instagram_response
    raw_posts = raw_posts.select_with_location
    assert_equal [3], raw_posts.map { |t| t['id'] }
  end  
  
  def test_select_new_posts
    instagram_response = [{'id' => 1}, {'id' => 2}, {'id' => 3}]
    new_posts = [{'id' => 2}]
    raw_posts = RawPosts.new @source_type, @source_id, instagram_response
    raw_posts =
      InstagramRecorder.stub :not_in_database, new_posts do
        raw_posts.select_new_posts
      end
    assert_equal [2], raw_posts.map { |t| t['id'] }
  end
end
