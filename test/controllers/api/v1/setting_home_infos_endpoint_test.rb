require "test_helper"
require "controllers/api/test"

class Api::V1::SettingHomeInfosEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@setting_home_info = create(:setting_home_info, site: @site)
      @other_setting_home_infos = create_list(:setting_home_info, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(setting_home_info_data)
      # Fetch the setting_home_info in question and prepare to compare it's attributes.
      setting_home_info = SettingHomeInfo.find(setting_home_info_data["id"])

      assert_equal setting_home_info_data['biography_blurb'], setting_home_info.biography_blurb
      assert_equal setting_home_info_data['video_billboard_url'], setting_home_info.video_billboard_url
      assert_equal setting_home_info_data['watch_this_video_url'], setting_home_info.watch_this_video_url
      assert_equal setting_home_info_data['bio_link_label'], setting_home_info.bio_link_label
      assert_equal setting_home_info_data['watch_this_poster_url'], setting_home_info.watch_this_poster_url
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal setting_home_info_data["site_id"], setting_home_info.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/setting_home_infos", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      setting_home_info_ids_returned = response.parsed_body.dig("data").map { |setting_home_info| setting_home_info.dig("attributes", "id") }
      assert_includes(setting_home_info_ids_returned, @setting_home_info.id)

      # But not returning other people's resources.
      assert_not_includes(setting_home_info_ids_returned, @other_setting_home_infos[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/setting_home_infos/#{@setting_home_info.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/setting_home_infos/#{@setting_home_info.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      setting_home_info_data = Api::V1::SettingHomeInfoSerializer.new(build(:setting_home_info, site: nil)).serializable_hash.dig(:data, :attributes)
      setting_home_info_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/setting_home_infos",
        params: setting_home_info_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/setting_home_infos",
        params: setting_home_info_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/setting_home_infos/#{@setting_home_info.id}", params: {
        access_token: access_token,
        biography_blurb: 'Alternative String Value',
        video_billboard_url: 'Alternative String Value',
        watch_this_video_url: 'Alternative String Value',
        bio_link_label: 'Alternative String Value',
        watch_this_poster_url: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @setting_home_info.reload
      assert_equal @setting_home_info.biography_blurb, 'Alternative String Value'
      assert_equal @setting_home_info.video_billboard_url, 'Alternative String Value'
      assert_equal @setting_home_info.watch_this_video_url, 'Alternative String Value'
      assert_equal @setting_home_info.bio_link_label, 'Alternative String Value'
      assert_equal @setting_home_info.watch_this_poster_url, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/setting_home_infos/#{@setting_home_info.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("SettingHomeInfo.count", -1) do
        delete "/api/v1/setting_home_infos/#{@setting_home_info.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/setting_home_infos/#{@setting_home_info.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
