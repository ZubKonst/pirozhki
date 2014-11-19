require_relative 'record_builder_behavior'
require_relative '../spec_helper'

describe UserBuilder do
  it_behaves_like 'record builder' do
    subject { UserBuilder }
    let(:records) { User }
    let(:data) do
      response = FakeInstagramResponse.instance
      response.sample['user']
    end
  end
end

