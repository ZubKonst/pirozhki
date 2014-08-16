require_relative 'concerns/exportable'

class GeoPoint < ActiveRecord::Base
  has_many :posts

  include Exportable # add :export_attrs method
  add_export prefix: 'geo_point',
             export_fields:  %i[ id ],
             export_methods: %i[ long_lat ]

  def long_lat
    [ lng, lat ]
  end
end
