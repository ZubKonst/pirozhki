require_relative 'record_builder_behavior'
require_relative '../spec_helper'

describe LocationBuilder do
  it_behaves_like 'record builder' do
    subject { LocationBuilder }
    let(:records) { Location }
    let(:data) do
      response = FakeInstagramResponse.instance
      response.with_named_location['location']
    end
  end
end

