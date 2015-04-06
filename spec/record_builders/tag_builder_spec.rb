require_relative 'record_builder_behavior'
require_relative '../spec_helper'

describe TagBuilder do
  it_behaves_like 'record builder' do
    let :sample_data do
      response = FakeInstagramResponse.instance
      response.sample_with_tags['tags'].sample
    end
    let :collection_data do
      response = FakeInstagramResponse.instance
      response.all_with_tags.flat_map { |t| t['tags'] } .uniq
    end
  end
end

