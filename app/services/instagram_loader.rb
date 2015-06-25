class InstagramLoader

  def initialize source
    @source = source
  end

  def get_posts
    request_at = Time.now.to_i # To make BuildPost jobs idempotent
    posts = load_posts
    posts.each do |post|
      add_meta_data! post, request_at
    end
    posts
  end

  private

  def load_posts
    @source.load_posts request_params
  end

  def request_params
    params = {}
    params[:max_time] = request_max_time if request_max_time
    params
  end

  # In realtime we can not collect correct data about likes and comments.
  # 5 days delay will help.
  def request_max_time
    delay = Settings.instagram.request_delay
    return if delay == 0
    Time.now.to_i - delay
  end

  def add_meta_data! post_data, request_at
    post_data['meta'] ||= {}
    post_data['meta'].tap do |meta|
      meta['source_id']   = @source.id
      meta['source_type'] = @source.type_as_source
      meta['request_at']  = request_at # To make BuildPost jobs idempotent
    end
    post_data
  end

end
