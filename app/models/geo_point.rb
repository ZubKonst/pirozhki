require_relative 'concerns/exportable'

class GeoPoint < ActiveRecord::Base
  has_many :posts, as: :source
end
