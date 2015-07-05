class RawPosts
  include Adamantium

  include Enumerable
  def each
    @posts.each do |post|
      post_data = Hash[post]
      post_data['source'] = source_info
      yield post_data
    end
  end

  def initialize source_type, source_id, posts
    @source_type = source_type
    @source_id = source_id
    @posts  = posts
    @created_at = Time.now.to_i
  end

  memoize def select_new_posts
    new_posts = @posts.dup
    new_posts = InstagramRecorder.not_in_database @source_type, @source_id, new_posts
    RawPosts.new @source_type, @source_id, new_posts
  end

  memoize def select_with_location
    new_posts = @posts.dup
    new_posts = new_posts.select do |post|
      post['location'].present? &&
        post['location']['latitude'] &&
        post['location']['longitude']
    end
    RawPosts.new @source_type, @source_id, new_posts
  end

  memoize def select_with_tags
    new_posts = @posts.dup
    new_posts = new_posts.select do |post|
      post['tags'].any?
    end
    RawPosts.new @source_type, @source_id, new_posts
  end

  private

  memoize def source_info
    {
      'id'   => @source_id,
      'type' => @source_type,
    }
  end
end