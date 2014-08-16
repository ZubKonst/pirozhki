require_relative 'base_builder_helper'
require_relative '../spec_helper'

describe UserBuilder do
  include BaseBuilderHelper

  subject { UserBuilder }
  let(:records) { User }
  let(:data) do
    response = FakeInstagramResponse.instance
    response.sample['user']
  end
end

