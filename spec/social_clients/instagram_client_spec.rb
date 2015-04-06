require_relative '../spec_helper'

describe InstagramClient do

  let :instagram_gem do
    spy 'instagram'
  end

  subject! do
    client = InstagramClient.new
    allow(client).to receive(:client) { instagram_gem }
    client
  end

  context '#media_search' do

    shared_examples 'an Instagram-API client' do
      it 'make a request with expected_values' do
        subject.media_search *send_values
        expect(instagram_gem).to have_received(:media_search).with *expected_values
      end
    end

    context 'with geo' do
      let :send_values do
        [
          55.55, 33.33
        ]
      end
      let :expected_values do
        [
          55.55, 33.33,
          {
            distance: 5000, count: 100,
            min_timestamp: nil, max_timestamp: nil
          }
        ]
      end
      include_examples 'an Instagram-API client'
    end

    context 'with geo and max_time' do
      let :send_values do
        [
          55.55, 33.33,
          {max_time: 1_400_000_000}
        ]
      end
      let :expected_values do
        [
          55.55, 33.33,
          {
            distance: 5000, count: 100,
            min_timestamp: nil, max_timestamp: 1_400_000_000
          }
        ]
      end
      include_examples 'an Instagram-API client'
    end

    context 'with geo and min_time and dist' do
      let :send_values do
        [
          55.55, 33.33,
          {min_time: 123_456, dist: 4000}
        ]
      end
      let :expected_values do
        [
          55.55, 33.33,
          {
            distance: 4000, count: 100,
            min_timestamp: 123_456, max_timestamp: nil
          }
        ]
      end
      include_examples 'an Instagram-API client'
    end
  end
end
