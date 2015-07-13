require 'yaml'

class FakeInstagramLoader

  def initialize source = nil
    @instagram_response = load_response
    @source = source || create_source
  end

  def get_posts
    RawPosts.new @source.type_as_source, @source.id, @instagram_response
  end

  private

  def create_source
    Source::Hashtag.create! tag_name: 'Omsk'
  end

  def load_response
    YAML.load_file "#{APP_ROOT}/test/helpers/instagram_response.yml"
  end
end
