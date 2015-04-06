require_relative 'record_builder_behavior'
require_relative '../spec_helper'

describe UserBuilder do
  it_behaves_like 'record builder' do
    let :sample_data do
      response = FakeInstagramResponse.instance
      response.sample['user']
    end
    let :collection_data do
      response = FakeInstagramResponse.instance
      response.all.map { |t| t['user'] }
    end
  end
end

