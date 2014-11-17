require_relative '../spec_helper'

describe Post do

  context '#export_data' do

    let(:post) do
      response = FakeInstagramResponse.instance
      @post_data = response.sample_with_meta
      post = PostBuilder.find_or_create_with_counter!(@post_data)
      add_geo_point(post)
    end

    def add_geo_point(post)
      gp = GeoPoint.create!(lat: rand*100, lng: rand*100)
      post.update_attributes geo_point: gp
      post
    end

    context 'structure validation' do
      it 'return data with all required fields' do
        required_fields =
          %w[post_id post_instagram_id post_created_time post_content_type post_caption
           post_tags post_tags_count post_tagged_users_count post_likes_count post_comments_count
           user_id user_instagram_id user_nick_name
           geo_point_id geo_point_long_lat
           location_id location_instagram_id location_name location_long_lat
           filter_id filter_name ]

        export_data = post.export_data
        expect(export_data.keys).to match_array(required_fields)
      end
    end

    context 'content validation' do
      # TODO use sample where all counters > 0
      it 'has valid counters' do
        export_data = post.export_data

        expect(export_data['post_tags_count']).to eq(@post_data['tags'].count)
        expect(export_data['post_tagged_users_count']).to eq(@post_data['users_in_photo'].count)
        expect(export_data['post_likes_count']).to eq(@post_data['likes']['count'])
        expect(export_data['post_comments_count']).to eq(@post_data['comments']['count'])
      end

      it 'has valid tags' do
        export_data = post.export_data

        expect(export_data['post_tags']).to match_array(@post_data['tags'])
      end
    end

  end
end
