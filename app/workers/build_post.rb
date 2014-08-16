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
    PostBuilder.find_or_create_with_counter!(post_data)
  end

  def enqueue_export(post)
    LogstashExport.perform_async( post.id )
  end
end

