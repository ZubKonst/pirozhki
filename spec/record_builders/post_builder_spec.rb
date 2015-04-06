require_relative 'record_builder_behavior'
require_relative '../spec_helper'

describe PostBuilder do
  let :sample_data do
    response = FakeInstagramResponse.instance
    response.sample_with_meta
  end
  let :collection_data do
    response = FakeInstagramResponse.instance
    response.all_with_meta
  end

  include_examples 'record builder'

  context '.not_existed' do
    let :full_posts_data do
      response = FakeInstagramResponse.instance
      response.all_with_meta
    end

    def randomly_split arr
      new_arr = [[],[]]
      arr.each { |e| new_arr[rand 2] << e }
      new_arr
    end

    it 'select not created posts_data' do
      created_posts, not_created_posts = randomly_split full_posts_data
      created_posts.each do |post_data|
        PostBuilder.find_or_create! post_data
      end
      expect(PostBuilder.not_existed full_posts_data).to eq not_created_posts
    end
  end

end
