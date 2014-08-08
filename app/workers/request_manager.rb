class RequestManager
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options queue: :request_manager

  # https://github.com/tobiassvn/sidetiq/issues/31
  recurrence { hourly.minute_of_hour( *(0..59).step(1).to_a ) }

  def perform
    all_geo_points.each do |geo_point|
      init_load( geo_point.id )
    end
  end

  def all_geo_points
    GeoPoint.order('RANDOM()')
  end

  def init_load(geo_point_id)
    LoadByGeoPoint.perform_async(geo_point_id)
  end
end

