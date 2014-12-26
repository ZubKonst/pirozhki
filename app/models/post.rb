require_relative 'concerns/exportable'

class Post < ActiveRecord::Base
  belongs_to :geo_point
  belongs_to :user
  belongs_to :filter
  belongs_to :location

  has_many :posts_tags, dependent: :destroy
  has_many :tags, through: :posts_tags

  has_many :users_in_posts, dependent: :destroy
  has_many :tagged_users, through: :users_in_posts, source: :user

  enum content_type: { image: 0, video: 1 }

  before_validation(on: :create) { |t| t.created_time ||= Time.now.to_i }
  before_validation { |t| t.updated_time = Time.now.to_i }

  def export_data
    data_sources = [self, user, geo_point, location, filter]
    data_sources.each_with_object({}) do |data_source, export_hash|
      data_attrs = data_source.export_attrs
      export_hash.merge!( data_attrs )
    end
  end

  include Exportable # add :export_attrs method
  add_export prefix: 'post',
             export_fields: %i[ id instagram_id created_time content_type caption likes_count comments_count ],
             extra_fields: :extra_export

  def extra_export
    {
      'tags'               => tags.pluck(:name),
      'tags_count'         => tags.count,
      'tagged_users_count' => tagged_users.count
    }
  end
end
