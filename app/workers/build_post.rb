class BuildPost
  include Sidekiq::Worker

  sidekiq_options queue: :build_post

  def perform post_data
    post = InstagramRecorder.create_from_hash post_data
    ExportPost.perform_async post.id
  end
end

