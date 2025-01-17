require "test_helper"
require "controllers/api/test"

class Api::V1::MediaAppearancesEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@media_appearance = create(:media_appearance, site: @site)
      @other_media_appearances = create_list(:media_appearance, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(media_appearance_data)
      # Fetch the media_appearance in question and prepare to compare it's attributes.
      media_appearance = MediaAppearance.find(media_appearance_data["id"])

      assert_equal media_appearance_data['title'], media_appearance.title
      assert_equal Date.parse(media_appearance_data['published_on']), media_appearance.published_on
      assert_equal media_appearance_data['article_url'], media_appearance.article_url
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal media_appearance_data["site_id"], media_appearance.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/media_appearances", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      media_appearance_ids_returned = response.parsed_body.dig("data").map { |media_appearance| media_appearance.dig("attributes", "id") }
      assert_includes(media_appearance_ids_returned, @media_appearance.id)

      # But not returning other people's resources.
      assert_not_includes(media_appearance_ids_returned, @other_media_appearances[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/media_appearances/#{@media_appearance.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/media_appearances/#{@media_appearance.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      media_appearance_data = Api::V1::MediaAppearanceSerializer.new(build(:media_appearance, site: nil)).serializable_hash.dig(:data, :attributes)
      media_appearance_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/media_appearances",
        params: media_appearance_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/media_appearances",
        params: media_appearance_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/media_appearances/#{@media_appearance.id}", params: {
        access_token: access_token,
        title: 'Alternative String Value',
        article_url: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @media_appearance.reload
      assert_equal @media_appearance.title, 'Alternative String Value'
      assert_equal @media_appearance.article_url, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/media_appearances/#{@media_appearance.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("MediaAppearance.count", -1) do
        delete "/api/v1/media_appearances/#{@media_appearance.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/media_appearances/#{@media_appearance.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
