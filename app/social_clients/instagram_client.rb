class InstagramClient

  def initialize(token=nil)
    @client = init_client(token)
    @timeout = 60
  end

  def media_search(lat, lng, args={})
    dist = args[:dist] || 5000
    min_time = args[:min_time]
    max_time = args[:max_time]

    timeout do
      @client.media_search(
        lat, lng,
        distance: dist, count: 100,
        min_timestamp: min_time, max_timestamp: max_time
      ).reverse
    end
  end

  private

  def init_client(token)
    if token
      Instagram.client(access_token: session[:access_token])
    else
      Instagram.client
    end
  end

  def timeout
    Timeout.timeout(@timeout) { yield }
  end
end
