class ExportPost
  include Sidekiq::Worker

  sidekiq_options queue: :export_post

  def perform post_id
    post = load_post post_id
    export_post post
  end

  def load_post post_id
    Post.find_by! id: post_id
  end

  def export_post post
    $exporter.info post.export_data
  end
end

