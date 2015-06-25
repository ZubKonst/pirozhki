class RequestManager
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options queue: :request_manager

  # https://github.com/tobiassvn/sidetiq/issues/31
  recurrence do
    minutes_range = Range.new 0, 59
    minutes_list  = minutes_range.to_a
    hourly.minute_of_hour *minutes_list
  end


  def perform
    sources = all_sources
    sources.each { |source| init_load source }
  end

  private

  def all_sources
    sources = GeoPoint.all + Hashtag.all
    sources.shuffle # Slow but works
  end

  def init_load source
    LoadFromSource.perform_async source.type_as_source, source.id
  end
end

