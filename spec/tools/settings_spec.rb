require_relative '../spec_helper'

describe Settings do
  describe '#instagram request_delay' do
    it 'default value is 0' do
      expect(Settings.instagram.request_delay).to eq(0)
    end
  end
end
