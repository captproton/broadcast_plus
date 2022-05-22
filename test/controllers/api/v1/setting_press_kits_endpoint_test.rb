require "test_helper"
require "controllers/api/test"

class Api::V1::SettingPressKitsEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@setting_press_kit = create(:setting_press_kit, site: @site)
      @other_setting_press_kits = create_list(:setting_press_kit, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(setting_press_kit_data)
      # Fetch the setting_press_kit in question and prepare to compare it's attributes.
      setting_press_kit = SettingPressKit.find(setting_press_kit_data["id"])

      assert_equal setting_press_kit_data['hero_title'], setting_press_kit.hero_title
      assert_equal setting_press_kit_data['hero_image'], setting_press_kit.hero_image
      assert_equal setting_press_kit_data['name'], setting_press_kit.name
      assert_equal setting_press_kit_data['birthplace'], setting_press_kit.birthplace
      assert_equal Date.parse(setting_press_kit_data['birthdate']), setting_press_kit.birthdate
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal setting_press_kit_data["site_id"], setting_press_kit.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/setting_press_kits", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      setting_press_kit_ids_returned = response.parsed_body.dig("data").map { |setting_press_kit| setting_press_kit.dig("attributes", "id") }
      assert_includes(setting_press_kit_ids_returned, @setting_press_kit.id)

      # But not returning other people's resources.
      assert_not_includes(setting_press_kit_ids_returned, @other_setting_press_kits[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/setting_press_kits/#{@setting_press_kit.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/setting_press_kits/#{@setting_press_kit.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      setting_press_kit_data = Api::V1::SettingPressKitSerializer.new(build(:setting_press_kit, site: nil)).serializable_hash.dig(:data, :attributes)
      setting_press_kit_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/setting_press_kits",
        params: setting_press_kit_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/setting_press_kits",
        params: setting_press_kit_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/setting_press_kits/#{@setting_press_kit.id}", params: {
        access_token: access_token,
        hero_title: 'Alternative String Value',
        name: 'Alternative String Value',
        birthplace: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @setting_press_kit.reload
      assert_equal @setting_press_kit.hero_title, 'Alternative String Value'
      assert_equal @setting_press_kit.name, 'Alternative String Value'
      assert_equal @setting_press_kit.birthplace, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/setting_press_kits/#{@setting_press_kit.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("SettingPressKit.count", -1) do
        delete "/api/v1/setting_press_kits/#{@setting_press_kit.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/setting_press_kits/#{@setting_press_kit.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
