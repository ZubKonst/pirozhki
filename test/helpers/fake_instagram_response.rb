require 'yaml'

class FakeInstagramResponse
  extend Forwardable

  def initialize geo_point_id=nil
    @geo_point_id = geo_point_id || fake_geo_point_id
    @response = YAML.load_file "#{APP_ROOT}/test/helpers/instagram_response.yml"
  end

  def_delegators :@response, :sample
  def all; @response; end

  def all_with_tags
    all.select { |t| t['tags'].any? }
  end

  def sample_with_tags
    all.find { |t| t['tags'].any? }
  end

  def all_with_named_location
    all.select { |t| t['location']['id'] }
  end

  def all_with_meta
    all.map { |post_data| add_fake_meta post_data }
  end

  def sample_with_meta
    post_data = sample_with_tags
    add_fake_meta post_data
  end

  private

  def fake_geo_point_id
    rand 777
  end

  def add_fake_meta post_data
    post_data['meta'] ||= {}
    post_data['meta']['geo_point_id'] = @geo_point_id
    rand_time = rand * 1.week
    post_data['meta']['request_at'] = Time.now.to_i - rand_time.to_i
    post_data
  end
end
