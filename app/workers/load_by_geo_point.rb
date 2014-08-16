class LoadByGeoPoint
  include Sidekiq::Worker
  include Sidekiq::Benchmark::Worker

  # The job will be unique for the number of seconds configured (default 30 minutes) or until the job has been completed.
  sidekiq_options queue: :api_request,
                  unique: true,
                  throttle: { threshold: 4_900, period: 1.hour.to_i, key: 'api_request' }


  # In realtime we can not collect correct data about likes and comments.
  # 5 days delay will help.
  class << self; attr_reader :request_max_time end
  @request_max_time = -> { 5.days.ago.to_i }

  def perform(geo_point_id)
    @request_at = Time.now.to_i # To make jobs idempotent

    benchmark.find_geo_point do
      @geo_point  = find_geo_point(geo_point_id)
    end

    benchmark.get_posts do
      @posts = load_posts(@geo_point)
    end

    benchmark.enqueue_posts_data do
      enqueue_posts_data(@posts)
    end

    benchmark.finish
  end


  def find_geo_point(geo_point_id)
    GeoPoint.find(geo_point_id)
  end

  def load_posts(geo_point)
    params = {max_time: self.class.request_max_time.call }
    InstagramClient.new.media_search(geo_point.lat, geo_point.lng, params)
  end

  def enqueue_posts_data(posts)
    not_existed_posts = PostBuilder.not_existed(posts)
    not_existed_posts.each do |post_data|
      add_meta_data!(post_data)
      build_post(post_data)
    end
  end

  def add_meta_data!(post_data)
    post_data['meta'] ||= {}
    post_data['meta']['geo_point_id'] = @geo_point.id
    post_data['meta']['request_at']   = @request_at # To make jobs idempotent
    post_data
  end

  def build_post(post_data)
    BuildPost.perform_async( post_data.to_hash )
  end
end
