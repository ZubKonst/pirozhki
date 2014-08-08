class Location < ActiveRecord::Base
  has_many :posts

  def long_lat
    [ lng, lat ]
  end

  def export_attrs
    export_fields = %i[ id instagram_id name ]
    attrs = self.as_json(only: export_fields)
    attrs['long_lat'] = long_lat
    Hash[ attrs.map { |k,v| ["location_#{k}", v] } ]
  end
end
