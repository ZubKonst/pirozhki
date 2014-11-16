require_relative '../spec_helper'

describe InstagramClient do

  subject { InstagramClient.new }

  describe '#media_search' do
    it 'call client with arguments' do
      send_values     = [55.55, 33.33, {max_time: 1_400_000_000}]
      expected_values = [55.55, 33.33, {distance: 5000, count: 100, min_timestamp: nil, max_timestamp: 1_400_000_000}]
      instagram_gem = spy('instagram')
      allow(subject).to receive(:client) { instagram_gem }

      subject.media_search(*send_values)

      expect(instagram_gem).to have_received(:media_search).with(*expected_values)
    end
  end
end
