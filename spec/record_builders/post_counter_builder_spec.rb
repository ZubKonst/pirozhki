require_relative 'record_builder_behavior'
require_relative '../spec_helper'

describe PostCounterBuilder do
  it_behaves_like 'record builder' do
    subject { PostCounterBuilder }
    let(:records) { PostCounter }
    let(:data) do
      response = FakeInstagramResponse.instance
      post_data = response.sample_with_meta

      post = PostBuilder.new(post_data).find_or_create!
      {post_record: post, raw_post_data: post_data}
    end
  end
end

