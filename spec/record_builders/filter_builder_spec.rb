require_relative 'base_builder_helper'
require_relative '../spec_helper'

describe FilterBuilder do
  include BaseBuilderHelper

  subject { FilterBuilder }
  let(:records) { Filter }
  let(:data) do
    response = FakeInstagramResponse.instance
    response.sample['filter']
  end
end

