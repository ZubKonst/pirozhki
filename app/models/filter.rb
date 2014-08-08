class Filter < ActiveRecord::Base
  has_many :posts

  def export_attrs
    export_fields = %i[ id name ]
    attrs = self.as_json(only: export_fields)
    Hash[ attrs.map { |k,v| ["filter_#{k}", v] } ]
  end
end
