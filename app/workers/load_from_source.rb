class LoadFromSource
  include Sidekiq::Worker

  # The job will be unique for the number of seconds configured [default 30 minutes] or until the job has been completed.
  sidekiq_options queue: :load_from_source,
                  unique: true,
                  throttle: { threshold: 80, period: 1.minute.to_i, key: 'instagram_api_request' }


  def perform source_type, source_id
    source = find_source source_type, source_id
    loader = InstagramLoader.new source
    posts  = loader.get_posts
    posts  = select_new_posts source, posts
    posts  = select_with_location posts
    posts.each { |post| build_post post }
  end

  def find_source source_type, source_id
    source_class =
      case source_type
        when 'GeoPoint' then GeoPoint
        when 'Hashtag'  then Hashtag
        else raise "Unknown source type #{source_type}"
      end
    source_class.find source_id
  end

  def select_new_posts source, posts
    InstagramRecorder.not_in_database source, posts
  end

  def select_with_location posts
    InstagramRecorder.select_with_location posts
  end

  def build_post post_data
    BuildPost.perform_async post_data.to_hash
  end
end
