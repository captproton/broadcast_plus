require "test_helper"
require "controllers/api/test"

class Api::V1::NewslettersEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@newsletter = create(:newsletter, site: @site)
      @other_newsletters = create_list(:newsletter, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(newsletter_data)
      # Fetch the newsletter in question and prepare to compare it's attributes.
      newsletter = Newsletter.find(newsletter_data["id"])

      assert_equal newsletter_data['title'], newsletter.title
      assert_equal newsletter_data['mailing_group'], newsletter.mailing_group
      assert_equal newsletter_data['sender'], newsletter.sender
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal newsletter_data["site_id"], newsletter.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/newsletters", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      newsletter_ids_returned = response.parsed_body.dig("data").map { |newsletter| newsletter.dig("attributes", "id") }
      assert_includes(newsletter_ids_returned, @newsletter.id)

      # But not returning other people's resources.
      assert_not_includes(newsletter_ids_returned, @other_newsletters[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/newsletters/#{@newsletter.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/newsletters/#{@newsletter.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      newsletter_data = Api::V1::NewsletterSerializer.new(build(:newsletter, site: nil)).serializable_hash.dig(:data, :attributes)
      newsletter_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/newsletters",
        params: newsletter_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/newsletters",
        params: newsletter_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/newsletters/#{@newsletter.id}", params: {
        access_token: access_token,
        title: 'Alternative String Value',
        mailing_group: 'Alternative String Value',
        sender: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @newsletter.reload
      assert_equal @newsletter.title, 'Alternative String Value'
      assert_equal @newsletter.mailing_group, 'Alternative String Value'
      assert_equal @newsletter.sender, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/newsletters/#{@newsletter.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("Newsletter.count", -1) do
        delete "/api/v1/newsletters/#{@newsletter.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/newsletters/#{@newsletter.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
