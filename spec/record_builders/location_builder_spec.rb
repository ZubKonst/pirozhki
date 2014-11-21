require_relative 'record_builder_behavior'
require_relative '../spec_helper'

describe LocationBuilder do
  it_behaves_like 'record builder' do
    subject { LocationBuilder }
    let(:records) { Location }
    let(:sample_data) do
      response = FakeInstagramResponse.instance
      response.sample_with_named_location['location']
    end
    let(:collection_data) do
      response = FakeInstagramResponse.instance
      response.all_with_named_location.map { |t| t['location'] }
    end
  end
end

