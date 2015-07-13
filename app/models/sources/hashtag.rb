module Source
  class Hashtag < ActiveRecord::Base
    has_many :posts, as: :source
    def type_as_source ; 'Source::Hashtag' end

    def load_posts request_params={}
      posts_data = InstagramClient.new.search_by_hashtag tag_name, request_params
      RawPosts.new type_as_source, id, posts_data
    end
  end
end
