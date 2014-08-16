require_relative 'base_builder_helper'
require_relative '../spec_helper'

describe LocationBuilder do
  include BaseBuilderHelper

  subject { LocationBuilder }
  let(:records) { Location }
  let(:data) do
    response = FakeInstagramResponse.instance
    response.with_named_location['location']
  end
end

