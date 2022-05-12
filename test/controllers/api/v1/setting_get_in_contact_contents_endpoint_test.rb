require "test_helper"
require "controllers/api/test"

class Api::V1::SettingGetInContactContentsEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@setting_get_in_contact_content = create(:setting_get_in_contact_content, site: @site)
      @other_setting_get_in_contact_contents = create_list(:setting_get_in_contact_content, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(setting_get_in_contact_content_data)
      # Fetch the setting_get_in_contact_content in question and prepare to compare it's attributes.
      setting_get_in_contact_content = SettingGetInContactContent.find(setting_get_in_contact_content_data["id"])

      assert_equal setting_get_in_contact_content_data['first_name'], setting_get_in_contact_content.first_name
      assert_equal setting_get_in_contact_content_data['last_name'], setting_get_in_contact_content.last_name
      assert_equal setting_get_in_contact_content_data['youtube_url'], setting_get_in_contact_content.youtube_url
      assert_equal setting_get_in_contact_content_data['youtube_image_url'], setting_get_in_contact_content.youtube_image_url
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal setting_get_in_contact_content_data["site_id"], setting_get_in_contact_content.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/setting_get_in_contact_contents", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      setting_get_in_contact_content_ids_returned = response.parsed_body.dig("data").map { |setting_get_in_contact_content| setting_get_in_contact_content.dig("attributes", "id") }
      assert_includes(setting_get_in_contact_content_ids_returned, @setting_get_in_contact_content.id)

      # But not returning other people's resources.
      assert_not_includes(setting_get_in_contact_content_ids_returned, @other_setting_get_in_contact_contents[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/setting_get_in_contact_contents/#{@setting_get_in_contact_content.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/setting_get_in_contact_contents/#{@setting_get_in_contact_content.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      setting_get_in_contact_content_data = Api::V1::SettingGetInContactContentSerializer.new(build(:setting_get_in_contact_content, site: nil)).serializable_hash.dig(:data, :attributes)
      setting_get_in_contact_content_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/setting_get_in_contact_contents",
        params: setting_get_in_contact_content_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/setting_get_in_contact_contents",
        params: setting_get_in_contact_content_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/setting_get_in_contact_contents/#{@setting_get_in_contact_content.id}", params: {
        access_token: access_token,
        first_name: 'Alternative String Value',
        last_name: 'Alternative String Value',
        youtube_url: 'Alternative String Value',
        youtube_image_url: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @setting_get_in_contact_content.reload
      assert_equal @setting_get_in_contact_content.first_name, 'Alternative String Value'
      assert_equal @setting_get_in_contact_content.last_name, 'Alternative String Value'
      assert_equal @setting_get_in_contact_content.youtube_url, 'Alternative String Value'
      assert_equal @setting_get_in_contact_content.youtube_image_url, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/setting_get_in_contact_contents/#{@setting_get_in_contact_content.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("SettingGetInContactContent.count", -1) do
        delete "/api/v1/setting_get_in_contact_contents/#{@setting_get_in_contact_content.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/setting_get_in_contact_contents/#{@setting_get_in_contact_content.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
