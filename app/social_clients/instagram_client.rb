class InstagramClient

  def initialize(token=nil)
    @token = token
    @timeout = 60
  end

  def media_search(lat, lng, args={})
    dist = args[:dist] || 5000
    min_time = args[:min_time]
    max_time = args[:max_time]

    timeout do
      client.media_search(
        lat, lng,
        distance: dist, count: 100,
        min_timestamp: min_time, max_timestamp: max_time
      ).reverse
    end
  end

  private

  def client(rebuild=false)
    return @client if @client && !rebuild

    config = @token ? {access_token: @token} : {}
    @client = Instagram.client(config)
  end

  def timeout
    Timeout.timeout(@timeout) { yield }
  end
end
