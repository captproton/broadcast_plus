require "test_helper"
require "controllers/api/test"

class Api::V1::LegalTextsEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@legal_text = create(:legal_text, site: @site)
      @other_legal_texts = create_list(:legal_text, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(legal_text_data)
      # Fetch the legal_text in question and prepare to compare it's attributes.
      legal_text = LegalText.find(legal_text_data["id"])

      assert_equal legal_text_data['title'], legal_text.title
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal legal_text_data["site_id"], legal_text.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/legal_texts", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      legal_text_ids_returned = response.parsed_body.dig("data").map { |legal_text| legal_text.dig("attributes", "id") }
      assert_includes(legal_text_ids_returned, @legal_text.id)

      # But not returning other people's resources.
      assert_not_includes(legal_text_ids_returned, @other_legal_texts[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/legal_texts/#{@legal_text.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/legal_texts/#{@legal_text.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      legal_text_data = Api::V1::LegalTextSerializer.new(build(:legal_text, site: nil)).serializable_hash.dig(:data, :attributes)
      legal_text_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/legal_texts",
        params: legal_text_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/legal_texts",
        params: legal_text_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/legal_texts/#{@legal_text.id}", params: {
        access_token: access_token,
        title: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @legal_text.reload
      assert_equal @legal_text.title, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/legal_texts/#{@legal_text.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("LegalText.count", -1) do
        delete "/api/v1/legal_texts/#{@legal_text.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/legal_texts/#{@legal_text.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
