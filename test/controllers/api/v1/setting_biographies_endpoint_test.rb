require "test_helper"
require "controllers/api/test"

class Api::V1::SettingBiographiesEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@setting_biography = create(:setting_biography, site: @site)
      @other_setting_biographies = create_list(:setting_biography, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(setting_biography_data)
      # Fetch the setting_biography in question and prepare to compare it's attributes.
      setting_biography = SettingBiography.find(setting_biography_data["id"])

      assert_equal setting_biography_data['title'], setting_biography.title
      assert_equal setting_biography_data['hero_image'], setting_biography.hero_image
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal setting_biography_data["site_id"], setting_biography.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/setting_biographies", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      setting_biography_ids_returned = response.parsed_body.dig("data").map { |setting_biography| setting_biography.dig("attributes", "id") }
      assert_includes(setting_biography_ids_returned, @setting_biography.id)

      # But not returning other people's resources.
      assert_not_includes(setting_biography_ids_returned, @other_setting_biographies[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/setting_biographies/#{@setting_biography.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/setting_biographies/#{@setting_biography.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      setting_biography_data = Api::V1::SettingBiographySerializer.new(build(:setting_biography, site: nil)).serializable_hash.dig(:data, :attributes)
      setting_biography_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/setting_biographies",
        params: setting_biography_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/setting_biographies",
        params: setting_biography_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/setting_biographies/#{@setting_biography.id}", params: {
        access_token: access_token,
        title: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @setting_biography.reload
      assert_equal @setting_biography.title, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/setting_biographies/#{@setting_biography.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("SettingBiography.count", -1) do
        delete "/api/v1/setting_biographies/#{@setting_biography.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/setting_biographies/#{@setting_biography.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
