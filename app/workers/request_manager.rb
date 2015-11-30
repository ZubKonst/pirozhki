class RequestManager
  include Sidekiq::Worker

  sidekiq_options queue: :request_manager

  def perform
    Source.all_sources.each do |source|
      LoadFromSource.perform_async source.type_as_source, source.id
    end
  end
end
