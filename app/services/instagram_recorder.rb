require 'set'

class InstagramRecorder

  class << self
    def not_in_database source_type, source_id, posts_data
      instagram_ids = posts_data.map { |post_data| post_data['id'] }
      source = Source.find_source source_type, source_id
      exists_instagram_ids = source.posts.pluck_where :instagram_id, instagram_ids
      exists_instagram_ids = exists_instagram_ids.to_set
      posts_data.reject do |post_data|
        exists_instagram_ids.include? post_data['id']
      end
    end

    def create_from_hash api_response
      recorder = new api_response
      recorder.create
    end
  end

  def initialize api_response
    @data = api_response
  end

  def create
    records_info = {}
    records_info['user_id']     = create_user.id
    records_info['filter_id']   = create_filter.id
    records_info['location_id'] = create_location.id
    records_info['tag_ids']         = create_tags.map &:id
    records_info['tagged_user_ids'] = create_users_in_photo.map &:id
    create_post records_info
  end

  private

  def create_user
    UserBuilder.find_or_create! @data['user']
  end

  def create_filter
    FilterBuilder.find_or_create! @data['filter']
  end

  def create_location
    LocationBuilder.find_or_create! @data['location']
  end

  def create_tags
    @data['tags'].map do |tag|
      TagBuilder.find_or_create! tag
    end.uniq
  end

  def create_users_in_photo
    @data['users_in_photo'].map do |user_in_photo|
      UserBuilder.find_or_create! user_in_photo['user']
    end.uniq
  end

  def create_post records_info
    @data['related_records'] = records_info
    PostBuilder.find_or_create! @data
  end

end