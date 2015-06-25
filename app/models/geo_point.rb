class GeoPoint < ActiveRecord::Base
  has_many :posts, as: :source
  def type_as_source ; 'GeoPoint' end

  def load_posts request_params={}
    InstagramClient.new.search_by_location lat, lng, request_params
  end
end
