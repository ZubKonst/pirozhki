class GeoPoint < ActiveRecord::Base
  has_many :posts

  def long_lat
    [ lng, lat ]
  end

  def export_attrs
    export_fields = %i[ id ]
    attrs = self.as_json(only: export_fields)
    attrs['long_lat'] = long_lat
    Hash[ attrs.map { |k,v| ["geo_point_#{k}", v] } ]
  end
end
