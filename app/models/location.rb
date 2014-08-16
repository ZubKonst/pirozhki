require_relative 'concerns/exportable'

class Location < ActiveRecord::Base
  has_many :posts

  include Exportable # add :export_attrs method
  add_export prefix: 'location',
             export_fields:  %i[ id instagram_id name ],
             export_methods: %i[ long_lat ]


  def long_lat
    [ lng, lat ]
  end
end
