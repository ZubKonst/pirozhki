require 'set'

require_relative 'base_builder'

class PostBuilder < BaseBuilder
  MODEL = Post

  class << self
    def not_existed(posts_data)
      instagram_ids = posts_data.map { |t| t['id'] }
      exists_instagram_ids = Post.where(instagram_id: instagram_ids).pluck(:instagram_id)
      exists_instagram_ids = exists_instagram_ids.to_set
      posts_data.select { |t| !exists_instagram_ids.include?(t['id']) }
    end

    def find_or_create_with_counter!(post_data)
      post = PostBuilder.new(post_data).find_or_create!
      PostCounterBuilder.new(post_record: post, raw_post_data: post_data).find_or_create!
      post
    end
  end

  def attrs
    base_attrs =
      {
        instagram_id: @data['id'],
        geo_point_id: @data['meta']['geo_point_id'],
      }

    base_attrs.merge! records_attrs
    base_attrs.merge! content_attrs
    base_attrs.merge! time_attrs
    base_attrs
  end

  private

  def uniq_attrs
    { instagram_id: @data['id'] }
  end

  # Attributes that are dependent on other recordings.
  def records_attrs
    {
      user_id: user.id,
      filter_id: filter.id,
      location_id: location.id,

      tag_ids: tags.map(&:id),
      tagged_user_ids: users_in_photo.map(&:id)
    }
  end

  def content_attrs
    {
      content_type: @data['type'],
      caption: @data['caption'].try(:[], :text),
      instagram_link: @data['link'],
      image_link: image_link,
      video_link: video_link
    }
  end

  def time_attrs
    {
      created_time: @data['created_time'].to_i
    }
  end

  def user
    UserBuilder.new(@data['user']).find_or_create!
  end

  def filter
    FilterBuilder.new(@data['filter']).find_or_create!
  end

  def location
    LocationBuilder.new(@data['location']).find_or_create!
  end

  def tags
    @data['tags'].map do |tag|
      TagBuilder.new(tag).find_or_create!
    end
  end

  def users_in_photo
    @data['users_in_photo'].map do |user_in_photo|
      UserBuilder.new(user_in_photo['user']).find_or_create!
    end
  end

  def image_link
    biggest_image = @data['images'].values.max_by {|image| image['width']}
    biggest_image['url']
  end

  def video_link
    if @data['videos']
      biggest_video = @data['videos'].values.max_by {|image| image['width']}
      biggest_video['url']
    end
  end
end
