class BuildPost
  include Sidekiq::Worker
  include Sidekiq::Benchmark::Worker

  sidekiq_options queue: :build_record

  def perform(post_data)
    benchmark.build_post do
      @post = build_post(post_data)
    end

    benchmark.enqueue_export do
      enqueue_export(@post)
    end

    benchmark.finish
  end


  def build_post(post_data)
    post = PostBuilder.new(post_data).find_or_create!
    PostCounterBuilder.new(post, post_data).find_or_create!
    post
  end

  def enqueue_export(post)
    LogstashExport.perform_async( post.id )
  end
end

