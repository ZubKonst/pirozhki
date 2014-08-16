require_relative '../spec_helper'

describe Post do

  describe '#export_data' do

    let(:post) do
      response = FakeInstagramResponse.instance
      post_data = response.sample_with_meta
      PostBuilder.find_or_create_with_counter!(post_data)
    end

    def add_geo_point(post)
      gp = GeoPoint.create!(lat: rand*100, lng: rand*100)
      post.update_attributes geo_point: gp
      post
    end

    it 'return data with all required fields' do
      add_geo_point(post)

      required_fields =
        %w[post_id post_instagram_id post_created_time post_content_type post_caption
           post_tags post_tags_count post_tagged_users_count post_likes_count post_comments_count
           user_id user_instagram_id user_nick_name
           geo_point_id geo_point_long_lat
           location_id location_instagram_id location_name location_long_lat
           filter_id filter_name ]

      export_data = post.export_data
      export_data.keys.must_match_array required_fields
    end
  end
end
