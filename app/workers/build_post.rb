class BuildPost
  include Sidekiq::Worker

  sidekiq_options queue: :build_post

  def perform post_data
    post = build_post post_data
    enqueue_export post
  end

  def build_post post_data
    InstagramRecorder.create_from_hash post_data
  end

  def enqueue_export post
    ExportPost.perform_async post.id
  end
end

