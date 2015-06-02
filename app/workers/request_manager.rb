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
    geo_points = all_geo_points
    geo_points.each do |gp|
      init_load gp.id
    end
  end

  def all_geo_points
    GeoPoint.all.shuffle # Slow but works
  end

  def init_load geo_point_id
    LoadByGeoPoint.perform_async geo_point_id
  end
end

