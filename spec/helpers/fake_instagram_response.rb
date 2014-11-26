require 'yaml'

class FakeInstagramResponse
  include Singleton
  extend Forwardable

  def initialize
    @response = YAML.load_file("#{APP_ROOT}/spec/helpers/instagram_response.yml")
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

  def sample_with_named_location
    all.find { |t| t['location']['id'] }
  end

  def all_with_meta
    all.map { |post_data| add_fake_meta(post_data) }
  end

  def sample_with_meta
    post_data = sample
    add_fake_meta(post_data)
  end

  private

  def add_fake_meta(post_data)
    post_data['meta'] ||= {}
    post_data['meta']['geo_point_id'] = 7 # random number
    post_data['meta']['request_at']   = Time.now.to_i - (rand*1.week).to_i
    post_data
  end
end
