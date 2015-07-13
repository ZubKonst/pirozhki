require_relative '../test_helper'
require_relative '../helpers/fake_instagram_loader'

class TestInstagramRecorder < Minitest::Test

  def setup
    DatabaseCleaner.start
    @source = Source::GeoPoint.create! lat: rand*100, lng: rand*100
    instagram_response = FakeInstagramLoader.new @source
    @collection_data =
      instagram_response.get_posts.
        select_with_tags.
        select_with_location
    @sample_data = @collection_data.to_a.sample
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_create_record_from_api_response
    InstagramRecorder.create_from_hash @sample_data

    assert_predicate Post, :any?
    assert Post.exists? instagram_id: @sample_data['id']

    assert_predicate User, :any?
    assert User.exists? instagram_id: @sample_data['user']['id']

    assert_predicate Filter, :any?
    assert Filter.exists? name: @sample_data['filter']

    assert_predicate Location, :any?
    assert Location.exists? lat: @sample_data['location']['latitude'], lng: @sample_data['location']['longitude']

    assert_predicate Tag, :any?
    @sample_data['tags'].each do |tag|
      assert Tag.exists? name: tag
    end

    @sample_data['users_in_photo'].map do |user_in_photo|
      assert User.exists? instagram_id: user_in_photo['user']['id']
    end
  end

  def test_select_not_persisted_posts
    posts_to_create, posts_to_skip = randomly_split @collection_data
    posts_to_create.each do |post_data|
      InstagramRecorder.create_from_hash post_data
    end

    not_created_posts = InstagramRecorder.not_in_database @source.type_as_source, @source.id, @collection_data
    not_created_posts_ids = not_created_posts.map { |post_data| post_data['id'] }
    posts_to_skip_ids = posts_to_skip.map { |post_data| post_data['id'] }
    assert_equal posts_to_skip_ids.sort, not_created_posts_ids.sort
  end

  private

  def randomly_split arr
    arr.group_by { rand 2 } .values
  end

end
