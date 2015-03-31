require 'set'
require_relative 'base_builder'

class PostBuilder < BaseBuilder
  MODEL = Post

  class << self
    def not_existed posts_data
      instagram_ids = posts_data.map { |post_data| post_data['id'] }
      exists_instagram_ids = Post.pluck_where :instagram_id, instagram_ids
      exists_instagram_ids = exists_instagram_ids.to_set
      posts_data.select do |post_data|
        not exists_instagram_ids.include? post_data['id']
      end
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
    base_attrs.merge! counter_attrs
    base_attrs.merge! time_attrs
    base_attrs
  end

  private

  def uniq_attrs
    { instagram_id: @data['id'] }
  end

  # Attributes that are dependent on other recordings.
  def records_attrs
    tag_ids = tags.map &:id
    tagged_user_ids = users_in_photo.map &:id
    {
      user_id: user.id,
      filter_id: filter.id,
      location_id: location.id,

      tag_ids: tag_ids,
      tagged_user_ids: tagged_user_ids
    }
  end

  def content_attrs
    caption = @data['caption'] && @data['caption'][:text]
    {
      content_type: @data['type'],
      caption: caption,
      instagram_link: @data['link'],
      image_link: image_link,
      video_link: video_link
    }
  end

  def counter_attrs
    {
      likes_count:    @data['likes']['count'],
      comments_count: @data['comments']['count'],
    }
  end

  def time_attrs
    {
      created_time: @data['created_time'].to_i
    }
  end

  def user
    user_builder = UserBuilder.new @data['user']
    user_builder.find_or_create!
  end

  def filter
    filter_builder = FilterBuilder.new @data['filter']
    filter_builder.find_or_create!
  end

  def location
    location_builder = LocationBuilder.new @data['location']
    location_builder.find_or_create!
  end

  def tags
    @data['tags'].map do |tag|
      tag_builder = TagBuilder.new tag
      tag_builder.find_or_create!
    end
  end

  def users_in_photo
    @data['users_in_photo'].map do |user_in_photo|
      user_builder = UserBuilder.new user_in_photo['user']
      user_builder.find_or_create!
    end
  end

  def image_link
    biggest_image = @data['images'].values.max_by { |image| image['width'] }
    biggest_image['url']
  end

  def video_link
    if @data['videos']
      biggest_video = @data['videos'].values.max_by {|image| image['width']}
      biggest_video['url']
    end
  end
end
