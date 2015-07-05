require_relative 'sources/geo_point'
require_relative 'sources/hashtag'

module Source
  def self.find_source source_type, source_id
    source_class =
      case source_type
        when 'Source::GeoPoint' then GeoPoint
        when 'Source::Hashtag'  then Hashtag
        else raise "Unknown source type #{source_type}"
      end
    source_class.find source_id
  end

  def self.all_sources
    sources = GeoPoint.all + Hashtag.all
    sources.shuffle # Slow but works
  end
end
