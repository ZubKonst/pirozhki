require_relative '../spec_helper'

describe Post do

  let :geo_point do
    GeoPoint.create! lat: rand*100, lng: rand*100
  end

  let :post_data do
    response = FakeInstagramResponse.instance
    response.sample_with_meta
  end

  subject :post do
    post = PostBuilder.find_or_create! post_data
    post.update! geo_point: geo_point
    post
  end

  context '#export_data' do
    subject :export_data do
      post.export_data
    end

    context 'structure validation' do
      it 'return data with all required fields' do
        required_fields =
          %w[ post_id post_instagram_id post_created_time post_content_type post_caption
           post_tags post_tags_count post_tagged_users_count post_likes_count post_comments_count
           user_id user_instagram_id user_nick_name
           geo_point_id geo_point_long_lat
           location_id location_instagram_id location_name location_long_lat
           filter_id filter_name ]

        expect(export_data.keys).to match_array required_fields
      end
    end

    context 'content validation' do
      # TODO use sample where all counters > 0
      it 'has valid counters' do
        expected_counters = {
          post_tags_count: post_data['tags'].count,
          post_tagged_users_count: post_data['users_in_photo'].count,
          post_likes_count: post_data['likes']['count'],
          post_comments_count: post_data['comments']['count']
        }.stringify_keys

        is_expected.to include expected_counters
      end

      it 'has valid tags' do
        expect(export_data['post_tags']).to match_array post_data['tags']
      end
    end

  end
end
