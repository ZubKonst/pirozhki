class RawPosts
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

  def select_new_posts!
    @posts = InstagramRecorder.not_in_database @source_type, @source_id, @posts
    self
  end

  def select_with_location!
    @posts.select! do |post|
      post['location'].present? &&
        post['location']['latitude'] &&
        post['location']['longitude']
    end
    self
  end

  def select_with_tags!
    @posts.select! do |post|
      post['tags'].any?
    end
    self
  end

  private

  def source_info
    {
      'id'   => @source_id,
      'type' => @source_type,
    }
  end
end
