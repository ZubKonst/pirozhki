module Source
  class GeoPoint < ActiveRecord::Base
    has_many :posts, as: :source
    def type_as_source ; 'Source::GeoPoint' end

    def load_posts request_params={}
      posts_data = InstagramClient.new.search_by_location lat, lng, request_params
      RawPosts.new type_as_source, id, posts_data
    end
  end
end
