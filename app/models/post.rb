require_relative 'concerns/exportable'
require_relative 'concerns/timestampable'

class Post < ActiveRecord::Base
  include Timestampable

  belongs_to :source, polymorphic: true

  belongs_to :user
  belongs_to :filter
  belongs_to :location

  has_many :posts_tags, dependent: :destroy
  has_many :tags, through: :posts_tags
  def tags_names ; tags.pluck :name end

  has_many :users_in_posts, dependent: :destroy
  has_many :tagged_users, through: :users_in_posts, source: :user

  enum content_type: { image: 0, video: 1 }

  def self.pluck_where key, value
    posts = where key => value
    posts.pluck key
  end

  def export_data
    data_sources = [self, user, location, filter]
    data_sources.each_with_object Hash.new do |data_source, export_hash|
      data_attrs = data_source.export_attrs
      export_hash.merge! data_attrs
    end
  end

  include Exportable
  add_export prefix: nil,
             export_fields: %i[ id instagram_id source_id source_type created_time content_type caption likes_count comments_count ],
             extra_fields: :extra_export

  def extra_export
    {
      'tags'               => tags_names,
      'tags_count'         => tags.count,
      'tagged_users_count' => tagged_users.count
    }
  end
end
