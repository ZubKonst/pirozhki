require_relative 'record_builder_behavior'
require_relative '../spec_helper'

describe TagBuilder do
  it_behaves_like 'record builder' do
    subject { TagBuilder }
    let(:records) { Tag }
    let(:data) do
      response = FakeInstagramResponse.instance
      response.with_tags['tags'].sample
    end
  end
end

