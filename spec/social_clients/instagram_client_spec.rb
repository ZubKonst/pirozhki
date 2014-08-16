require_relative '../spec_helper'

describe InstagramClient do

  let(:instagram_gem) { Minitest::Mock.new }

  describe '#media_search' do
    it 'call client with arguments' do
      send_values     = [55.55, 33.33, {max_time: 1_400_000_000}]
      expected_values = [55.55, 33.33, {distance: 5000, count: 100, min_timestamp: nil, max_timestamp: 1_400_000_000}]

      instagram_gem.expect :media_search, [], expected_values
      Instagram.stub :client, instagram_gem do |_|
        my_client = InstagramClient.new
        my_client.media_search(*send_values)
      end
      instagram_gem.verify
    end
  end
end
