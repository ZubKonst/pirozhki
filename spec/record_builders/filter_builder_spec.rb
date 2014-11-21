require_relative 'record_builder_behavior'
require_relative '../spec_helper'

describe FilterBuilder do
  it_behaves_like 'record builder' do
    subject { FilterBuilder }
    let(:records) { Filter }
    let(:sample_data) do
      response = FakeInstagramResponse.instance
      response.sample['filter']
    end
    let(:collection_data) do
      response = FakeInstagramResponse.instance
      response.all.map { |t| t['filter'] }
    end
  end
end

