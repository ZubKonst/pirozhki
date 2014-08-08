class Post < ActiveRecord::Base
  belongs_to :geo_point
  belongs_to :user
  belongs_to :filter
  belongs_to :location

  has_many :post_counters

  has_many :posts_tags, dependent: :destroy
  has_many :tags, through: :posts_tags

  has_many :users_in_posts, dependent: :destroy
  has_many :tagged_users, through: :users_in_posts, source: :user

  enum content_type: { image: 0, video: 1 }

  def last_post_counter
    self.post_counters.order(:created_time).last
  end

  def export_data
    data_sources = [self, user, geo_point, location, filter]
    data_sources.inject({}) do |data, data_source|
      data_attrs = data_source.export_attrs
      data.merge!( data_attrs )
      data
    end
  end

  def export_attrs
    export_fields = %i[ id instagram_id created_time content_type caption ]
    attrs = self.as_json(only: export_fields)

    attrs['tags'] = self.tags.pluck(:name)
    attrs['tags_count'] = attrs['tags'].count
    attrs['tagged_users_count'] = self.tagged_users.count

    post_counter = last_post_counter
    attrs['likes_count'] = post_counter.likes_count
    attrs['comments_count'] = post_counter.comments_count

    Hash[ attrs.map { |k,v| ["post_#{k}", v] } ]
  end

end
