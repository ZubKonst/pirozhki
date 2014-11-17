require_relative '../spec_helper'

describe InstagramClient do

  subject { InstagramClient.new }
  before do
    @instagram_gem = spy('instagram')
    allow(subject).to receive(:client) { @instagram_gem }
  end

  context '#media_search' do
    context 'call client with arguments' do
      it 'with default values' do
        send_values     = [55.55, 33.33]
        expected_values = [55.55, 33.33, {distance: 5000, count: 100, min_timestamp: nil, max_timestamp: nil}]

        subject.media_search(*send_values)

        expect(@instagram_gem).to have_received(:media_search).with(*expected_values)
      end

      it 'with changed values (geo + max_time)' do
        send_values     = [55.55, 33.33, {max_time: 1_400_000_000}]
        expected_values = [55.55, 33.33, {distance: 5000, count: 100, min_timestamp: nil, max_timestamp: 1_400_000_000}]

        subject.media_search(*send_values)

        expect(@instagram_gem).to have_received(:media_search).with(*expected_values)
      end

      it 'with changed values (geo + min_time + dist)' do
        send_values     = [44.55, 33.44, {min_time: 123_456, dist: 4000}]
        expected_values = [44.55, 33.44, {distance: 4000, count: 100, min_timestamp: 123_456, max_timestamp: nil}]

        subject.media_search(*send_values)

        expect(@instagram_gem).to have_received(:media_search).with(*expected_values)
      end
    end
  end
end
