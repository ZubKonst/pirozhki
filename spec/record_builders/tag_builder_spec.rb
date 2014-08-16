require_relative 'base_builder_helper'
require_relative '../spec_helper'

describe TagBuilder do
  include BaseBuilderHelper

  subject { TagBuilder }
  let(:records) { Tag }
  let(:data) do
    response = FakeInstagramResponse.instance
    response.with_tags['tags'].sample
  end
end

