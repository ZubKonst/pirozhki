class BuildPost
  include Sidekiq::Worker

  sidekiq_options queue: :build_post,
                  unique: :until_executed,
                  unique_args: :unique_args,
                  log_duplicate_payload: true

  def self.unique_args args
    post_data = args.first
    [ post_data['id'] ]
  end

  def perform post_data
    post = InstagramRecorder.create_from_hash post_data
    ExportPost.perform_async post.id
  end
end

