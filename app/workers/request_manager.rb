class RequestManager
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options queue: :request_manager

  # https://github.com/tobiassvn/sidetiq/issues/31
  recurrence { hourly.minute_of_hour( *(0..59).step(5).to_a ) }

  def perform
    geo_points = all_geo_points
    geo_points.each do |gp|
      init_load( gp.id )
    end
  end

  def all_geo_points
    GeoPoint.order('RANDOM()')
  end

  def init_load(geo_point_id)
    LoadByGeoPoint.perform_async(geo_point_id)
  end
end

