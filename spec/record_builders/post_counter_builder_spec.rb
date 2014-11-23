require_relative 'record_builder_behavior'
require_relative '../spec_helper'

describe PostCounterBuilder do
  it_behaves_like 'record builder' do
    subject { PostCounterBuilder }
    let(:records) { PostCounter }
    let(:sample_data) do
      response = FakeInstagramResponse.instance
      post_data = response.sample_with_meta

      post = PostBuilder.new(post_data).find_or_create!
      {post_record: post, raw_post_data: post_data}
    end
    let(:collection_data) do
      response = FakeInstagramResponse.instance
      posts_data = response.all_with_meta

      posts_data.map do |post_data|
        post = PostBuilder.new(post_data).find_or_create!
        {post_record: post, raw_post_data: post_data}
      end
    end
  end
end

