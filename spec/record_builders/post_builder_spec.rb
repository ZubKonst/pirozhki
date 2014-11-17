require_relative 'record_builder_behavior'
require_relative '../spec_helper'

describe PostBuilder do
  subject { PostBuilder }
  let(:records) { Post }
  let(:data) do
    response = FakeInstagramResponse.instance
    response.sample_with_meta
  end

  include_examples 'record builder'

  context 'self.find_or_create_with_counter!' do
    it 'create post and counter' do
      post = subject.find_or_create_with_counter!(data)
      expect(records.count).to eq(1)
      expect(post.post_counters.count).to eq(1)
    end

    it 'add counter to existed post' do
      post = subject.find_or_create_with_counter!(data)

      # new couners
      data['meta']['request_at'] = Time.now.to_i
      post = subject.find_or_create_with_counter!(data)

      expect(records.count).to eq(1)
      expect(post.post_counters.count).to eq(2)
    end

    it 'not create counter twice' do
      _post = subject.find_or_create_with_counter!(data)
      post = subject.find_or_create_with_counter!(data)

      expect(records.count).to eq(1)
      expect(post.post_counters.count).to eq(1)
    end
  end

  context 'self.not_existed' do

    let(:full_posts_data) do
      response = FakeInstagramResponse.instance
      response.all_with_meta
    end

    def randomly_split(arr)
      new_arr = [[],[]]
      arr.each { |e| new_arr[rand(2)] << e }
      new_arr
    end

    it 'select not created posts_data' do
      created_posts, not_created_posts = randomly_split(full_posts_data)
      created_posts.each { |post_data| PostBuilder.new(post_data).find_or_create! }
      expect(PostBuilder.not_existed(full_posts_data)).to eq(not_created_posts)
    end
  end

end
