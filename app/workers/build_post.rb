class BuildPost
  include Sidekiq::Worker

  sidekiq_options queue: :build_post

  def perform(post_data)
    post = build_post(post_data)
    enqueue_export(post)
  end


  def build_post(post_data)
    PostBuilder.find_or_create_with_counter!(post_data)
  end

  def enqueue_export(post)
    ExportPost.perform_async( post.id )
  end
end

