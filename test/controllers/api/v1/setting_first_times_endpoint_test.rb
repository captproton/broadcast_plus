require "test_helper"
require "controllers/api/test"

class Api::V1::SettingFirstTimesEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@setting_first_time = create(:setting_first_time, site: @site)
      @other_setting_first_times = create_list(:setting_first_time, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(setting_first_time_data)
      # Fetch the setting_first_time in question and prepare to compare it's attributes.
      setting_first_time = SettingFirstTime.find(setting_first_time_data["id"])

      assert_equal setting_first_time_data['hero_title'], setting_first_time.hero_title
      assert_equal setting_first_time_data['hero_image'], setting_first_time.hero_image
      assert_equal setting_first_time_data['first_name'], setting_first_time.first_name
      assert_equal setting_first_time_data['last_name'], setting_first_time.last_name
      assert_equal setting_first_time_data['featured_aside_image'], setting_first_time.featured_aside_image
      assert_equal setting_first_time_data['blurb'], setting_first_time.blurb
      assert_equal setting_first_time_data['twitter_handle'], setting_first_time.twitter_handle
      assert_equal setting_first_time_data['featured_youtube_video_url'], setting_first_time.featured_youtube_video_url
      assert_equal setting_first_time_data['youtube_video_poster_photo_url'], setting_first_time.youtube_video_poster_photo_url
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal setting_first_time_data["site_id"], setting_first_time.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/setting_first_times", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      setting_first_time_ids_returned = response.parsed_body.dig("data").map { |setting_first_time| setting_first_time.dig("attributes", "id") }
      assert_includes(setting_first_time_ids_returned, @setting_first_time.id)

      # But not returning other people's resources.
      assert_not_includes(setting_first_time_ids_returned, @other_setting_first_times[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/setting_first_times/#{@setting_first_time.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/setting_first_times/#{@setting_first_time.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      setting_first_time_data = Api::V1::SettingFirstTimeSerializer.new(build(:setting_first_time, site: nil)).serializable_hash.dig(:data, :attributes)
      setting_first_time_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/setting_first_times",
        params: setting_first_time_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/setting_first_times",
        params: setting_first_time_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/setting_first_times/#{@setting_first_time.id}", params: {
        access_token: access_token,
        hero_title: 'Alternative String Value',
        first_name: 'Alternative String Value',
        last_name: 'Alternative String Value',
        blurb: 'Alternative String Value',
        twitter_handle: 'Alternative String Value',
        featured_youtube_video_url: 'Alternative String Value',
        youtube_video_poster_photo_url: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @setting_first_time.reload
      assert_equal @setting_first_time.hero_title, 'Alternative String Value'
      assert_equal @setting_first_time.first_name, 'Alternative String Value'
      assert_equal @setting_first_time.last_name, 'Alternative String Value'
      assert_equal @setting_first_time.blurb, 'Alternative String Value'
      assert_equal @setting_first_time.twitter_handle, 'Alternative String Value'
      assert_equal @setting_first_time.featured_youtube_video_url, 'Alternative String Value'
      assert_equal @setting_first_time.youtube_video_poster_photo_url, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/setting_first_times/#{@setting_first_time.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("SettingFirstTime.count", -1) do
        delete "/api/v1/setting_first_times/#{@setting_first_time.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/setting_first_times/#{@setting_first_time.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
