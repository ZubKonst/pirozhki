require_relative 'base_builder'

class PostBuilder < BaseBuilder

  def self.not_existed(posts_data)
    instagram_ids = posts_data.map { |t| t['id'] }
    exists_instagram_ids = Post.where(instagram_id: instagram_ids).pluck(:instagram_id)
    exists_instagram_ids = Set.new( exists_instagram_ids )
    posts_data.select { |t| !exists_instagram_ids.include?(t['id']) }
  end

  private

  def model
    Post
  end

  def uniq_attrs
    { instagram_id: @data['id'] }
  end

  def attrs
    {
      instagram_id: @data['id'],
      geo_point_id: @data['meta']['geo_point_id'],

      user_id: user.id,
      filter_id:   filter.id,
      location_id: location.id,

      tag_ids: tags.map(&:id),
      tagged_user_ids: users_in_photo.map(&:id),

      created_time: @data['created_time'].to_i,
      updated_time: Time.now.to_i,

      content_type: @data['type'],
      caption: caption,

      instagram_link: @data['link'],
      image_link: image_link,
      video_link: video_link
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

  def caption
    @data['caption'].try(:[], :text)
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
