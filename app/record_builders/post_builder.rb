require_relative 'base_builder'

class PostBuilder < BaseBuilder
  MODEL = Post

  def attrs
    base_attrs = uniq_attrs
    base_attrs.merge! records_attrs
    base_attrs.merge! content_attrs
    base_attrs.merge! counter_attrs
    base_attrs.merge! time_attrs
    base_attrs
  end

  private

  def uniq_attrs
    {
      instagram_id: @data['id'],
      source_id:   @data['source']['id'],
      source_type: @data['source']['type']
    }
  end

  # Attributes that are dependent on other recordings.
  def records_attrs
    records_info = @data['related_records']
    {
      user_id:     records_info['user_id'],
      tag_ids:     records_info['tag_ids'],
      filter_id:   records_info['filter_id'],
      location_id: records_info['location_id'],
      tagged_user_ids: records_info['tagged_user_ids'],
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

  def image_link
    images = @data['images'].values
    biggest_image = images.max_by { |image| image['width'] }
    biggest_image['url']
  end

  def video_link
    if @data['videos']
      videos = @data['videos'].values
      biggest_video = videos.max_by {|image| image['width']}
      biggest_video['url']
    end
  end
end
