require "test_helper"
require "controllers/api/test"

class Api::V1::PressKitPhotoAndHeadshotsEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @setting_press_kit = create(:setting_press_kit, team: @team)
@press_kit_photo_and_headshot = create(:press_kit_photo_and_headshot, setting_press_kit: @setting_press_kit)
      @other_press_kit_photo_and_headshots = create_list(:press_kit_photo_and_headshot, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(press_kit_photo_and_headshot_data)
      # Fetch the press_kit_photo_and_headshot in question and prepare to compare it's attributes.
      press_kit_photo_and_headshot = PressKitPhotoAndHeadshot.find(press_kit_photo_and_headshot_data["id"])

      assert_equal press_kit_photo_and_headshot_data['title'], press_kit_photo_and_headshot.title
      assert_equal press_kit_photo_and_headshot_data['description'], press_kit_photo_and_headshot.description
      assert_equal press_kit_photo_and_headshot_data['dimensions_wxh'], press_kit_photo_and_headshot.dimensions_wxh
      assert_equal press_kit_photo_and_headshot_data['headshot_or_other'], press_kit_photo_and_headshot.headshot_or_other
      assert_equal Date.parse(press_kit_photo_and_headshot_data['publish_at']), press_kit_photo_and_headshot.publish_at
      assert_equal press_kit_photo_and_headshot_data['photo'], press_kit_photo_and_headshot.photo
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal press_kit_photo_and_headshot_data["setting_press_kit_id"], press_kit_photo_and_headshot.setting_press_kit_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/setting_press_kits/#{@setting_press_kit.id}/press_kit_photo_and_headshots", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      press_kit_photo_and_headshot_ids_returned = response.parsed_body.dig("data").map { |press_kit_photo_and_headshot| press_kit_photo_and_headshot.dig("attributes", "id") }
      assert_includes(press_kit_photo_and_headshot_ids_returned, @press_kit_photo_and_headshot.id)

      # But not returning other people's resources.
      assert_not_includes(press_kit_photo_and_headshot_ids_returned, @other_press_kit_photo_and_headshots[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/press_kit_photo_and_headshots/#{@press_kit_photo_and_headshot.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/press_kit_photo_and_headshots/#{@press_kit_photo_and_headshot.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      press_kit_photo_and_headshot_data = Api::V1::PressKitPhotoAndHeadshotSerializer.new(build(:press_kit_photo_and_headshot, setting_press_kit: nil)).serializable_hash.dig(:data, :attributes)
      press_kit_photo_and_headshot_data.except!(:id, :setting_press_kit_id, :created_at, :updated_at)

      post "/api/v1/setting_press_kits/#{@setting_press_kit.id}/press_kit_photo_and_headshots",
        params: press_kit_photo_and_headshot_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/setting_press_kits/#{@setting_press_kit.id}/press_kit_photo_and_headshots",
        params: press_kit_photo_and_headshot_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/press_kit_photo_and_headshots/#{@press_kit_photo_and_headshot.id}", params: {
        access_token: access_token,
        title: 'Alternative String Value',
        description: 'Alternative String Value',
        dimensions_wxh: 'Alternative String Value',
        headshot_or_other: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @press_kit_photo_and_headshot.reload
      assert_equal @press_kit_photo_and_headshot.title, 'Alternative String Value'
      assert_equal @press_kit_photo_and_headshot.description, 'Alternative String Value'
      assert_equal @press_kit_photo_and_headshot.dimensions_wxh, 'Alternative String Value'
      assert_equal @press_kit_photo_and_headshot.headshot_or_other, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/press_kit_photo_and_headshots/#{@press_kit_photo_and_headshot.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("PressKitPhotoAndHeadshot.count", -1) do
        delete "/api/v1/press_kit_photo_and_headshots/#{@press_kit_photo_and_headshot.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/press_kit_photo_and_headshots/#{@press_kit_photo_and_headshot.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
