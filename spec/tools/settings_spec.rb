require_relative '../spec_helper'

describe Settings do
  context '.instagram' do
    subject { Settings.instagram }

    it 'request_delay default value is 0' do
      expect(subject.request_delay).to eq 0
    end
  end
end
