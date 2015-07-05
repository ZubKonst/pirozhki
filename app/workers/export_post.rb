class ExportPost
  include Sidekiq::Worker

  sidekiq_options queue: :export_post

  def perform post_id
    post = Post.find_by! id: post_id
    $exporter.info post.export_data
  end
end

