class Hashtag < ActiveRecord::Base
  has_many :posts, as: :source
  def type_as_source ; 'Hashtag' end

  def load_posts request_params={}
    InstagramClient.new.search_by_hashtag tag_name, request_params
  end
end
