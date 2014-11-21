require_relative 'base_builder'

class PostCounterBuilder < BaseBuilder

  def initialize(post_record:, raw_post_data:)
    @post_record   = post_record
    @raw_post_data = raw_post_data
  end

  def attrs
    {
      post_id:        @post_record.id,
      likes_count:    @raw_post_data['likes']['count'],
      comments_count: @raw_post_data['comments']['count'],
      created_time:   @raw_post_data['meta']['request_at']
    }
  end

  private

  def model
    PostCounter
  end

  def uniq_keys
    [ :post_id, :created_time ]
  end
end
