require "test_helper"
require "controllers/api/test"

class Api::V1::SettingGeneralInfosEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@setting_general_info = create(:setting_general_info, site: @site)
      @other_setting_general_infos = create_list(:setting_general_info, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(setting_general_info_data)
      # Fetch the setting_general_info in question and prepare to compare it's attributes.
      setting_general_info = SettingGeneralInfo.find(setting_general_info_data["id"])

      assert_equal setting_general_info_data['site_name'], setting_general_info.site_name
      assert_equal setting_general_info_data['plain_text_name'], setting_general_info.plain_text_name
      assert_equal setting_general_info_data['text_number'], setting_general_info.text_number
      assert_equal setting_general_info_data['newsletter_subscription_url'], setting_general_info.newsletter_subscription_url
      assert_equal setting_general_info_data['default_meta_blurb'], setting_general_info.default_meta_blurb
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal setting_general_info_data["site_id"], setting_general_info.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/setting_general_infos", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      setting_general_info_ids_returned = response.parsed_body.dig("data").map { |setting_general_info| setting_general_info.dig("attributes", "id") }
      assert_includes(setting_general_info_ids_returned, @setting_general_info.id)

      # But not returning other people's resources.
      assert_not_includes(setting_general_info_ids_returned, @other_setting_general_infos[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/setting_general_infos/#{@setting_general_info.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/setting_general_infos/#{@setting_general_info.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      setting_general_info_data = Api::V1::SettingGeneralInfoSerializer.new(build(:setting_general_info, site: nil)).serializable_hash.dig(:data, :attributes)
      setting_general_info_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/setting_general_infos",
        params: setting_general_info_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/setting_general_infos",
        params: setting_general_info_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/setting_general_infos/#{@setting_general_info.id}", params: {
        access_token: access_token,
        site_name: 'Alternative String Value',
        plain_text_name: 'Alternative String Value',
        text_number: 'Alternative String Value',
        newsletter_subscription_url: 'Alternative String Value',
        default_meta_blurb: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @setting_general_info.reload
      assert_equal @setting_general_info.site_name, 'Alternative String Value'
      assert_equal @setting_general_info.plain_text_name, 'Alternative String Value'
      assert_equal @setting_general_info.text_number, 'Alternative String Value'
      assert_equal @setting_general_info.newsletter_subscription_url, 'Alternative String Value'
      assert_equal @setting_general_info.default_meta_blurb, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/setting_general_infos/#{@setting_general_info.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("SettingGeneralInfo.count", -1) do
        delete "/api/v1/setting_general_infos/#{@setting_general_info.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/setting_general_infos/#{@setting_general_info.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
