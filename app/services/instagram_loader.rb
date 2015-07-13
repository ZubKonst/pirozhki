class InstagramLoader

  def initialize source
    @source = source
  end

  def get_posts only_not_persisted: true, only_with_location: false
    raw_posts = @source.load_posts request_params
    raw_posts = raw_posts.select_with_location if only_with_location
    raw_posts = raw_posts.select_new_posts     if only_not_persisted
    raw_posts
  end

  private

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
end
