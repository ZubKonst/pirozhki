class ExportPost
  include Sidekiq::Worker

  # The job will be unique for the number of seconds configured (default 30 minutes) or until the job has been completed.
  sidekiq_options queue: :export_post,
                  unique: true


  def perform(post_id)
    post = load_post(post_id)
    export_post(post)
  end

  def load_post(post_id)
    Post.find_by!(id: post_id)
  end

  def export_post(post)
    $exporter.info( post.export_data )
  end
end

