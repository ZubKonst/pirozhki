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
    Source.all_sources.each do |source|
      LoadFromSource.perform_async source.type_as_source, source.id
    end
  end
end

