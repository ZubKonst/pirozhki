class LoadFromSource
  include Sidekiq::Worker

  # The job will be unique for the number of seconds configured [default 30 minutes] or until the job has been completed.
  sidekiq_options queue: :load_from_source,
                  unique: true,
                  throttle: { threshold: 80, period: 1.minute.to_i, key: 'instagram_api_request' }


  def perform source_type, source_id
    source = Source.find_source source_type, source_id
    loader = InstagramLoader.new source
    posts  = loader.get_posts only_not_persisted: true, only_with_location: true
    posts.each { |post| BuildPost.perform_async post.to_hash }
  end
end
