class InstagramClient

  def initialize token: nil, timeout: nil
    @token = token
    @timeout = timeout || 60
  end

  def media_search lat, lng, args={}
    dist  = args[:dist] || 5000
    count = args[:count] || 100
    min_time = args[:min_time]
    max_time = args[:max_time]

    search_params = {
      distance: dist, count: count,
      min_timestamp: min_time, max_timestamp: max_time
    }

    data =
      timeout do
        instagram.media_search lat, lng, search_params
      end
    data.reverse
  end

  private

  def instagram rebuild=false
    return @instagram if @instagram && !rebuild

    config = @token ? {access_token: @token} : {}
    @instagram = Instagram.client config
  end

  def timeout
    Timeout.timeout @timeout do
      yield
    end
  end
end
