class LoadByGeoPoint
  include Sidekiq::Worker

  # The job will be unique for the number of seconds configured (default 30 minutes) or until the job has been completed.
  sidekiq_options queue: :load_by_geo_point,
                  unique: true,
                  throttle: { threshold: 80, period: 1.minute.to_i, key: 'instagram_api_request' }

  def perform geo_point_id
    request_at = Time.now.to_i # To make jobs idempotent
    geo_point = find_geo_point geo_point_id
    posts = load_posts geo_point
    enqueue_posts_data posts, geo_point, request_at
  end


  def find_geo_point geo_point_id
    GeoPoint.find geo_point_id
  end


  def load_posts geo_point
    InstagramClient.new.media_search geo_point.lat, geo_point.lng, request_params
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



  def enqueue_posts_data posts, geo_point, request_at
    not_existed_posts = InstagramRecorder.not_in_database posts
    not_existed_posts.each do |post_data|
      add_meta_data! post_data, geo_point, request_at
      build_post post_data
    end
  end

  def add_meta_data! post_data, geo_point, request_at
    post_data['meta'] ||= {}
    post_data['meta']['geo_point_id'] = geo_point.id
    post_data['meta']['request_at']   = request_at # To make jobs idempotent
    post_data
  end

  def build_post post_data
    BuildPost.perform_async post_data.to_hash
  end
end
