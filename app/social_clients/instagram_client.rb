class InstagramClient

  def initialize timeout: nil
    @timeout = timeout || 60
  end

  def search_by_hashtag tag_name, args={}
    count = args[:count] || 100

    search_params = {
      count: count,
      min_tag_id: args[:min_tag_id],
      max_tag_id: args[:max_tag_id],
    }

    data =
      timeout do
        instagram.tag_recent_media tag_name, search_params
      end
    data.reverse
  end

  def search_by_location lat, lng, args={}
    dist  = args[:dist] || 5000
    count = args[:count] || 100

    search_params = {
      count: count, distance: dist,
      min_timestamp: args[:min_time],
      max_timestamp: args[:max_time],
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
    @instagram = Instagram.client
  end

  def timeout
    Timeout.timeout @timeout do
      yield
    end
  end
end
