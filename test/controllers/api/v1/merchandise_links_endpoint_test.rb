require "test_helper"
require "controllers/api/test"

class Api::V1::MerchandiseLinksEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @book = create(:book, team: @team)
@merchandise_link = create(:merchandise_link, book: @book)
      @other_merchandise_links = create_list(:merchandise_link, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(merchandise_link_data)
      # Fetch the merchandise_link in question and prepare to compare it's attributes.
      merchandise_link = MerchandiseLink.find(merchandise_link_data["id"])

      assert_equal merchandise_link_data['seller_name'], merchandise_link.seller_name
      assert_equal merchandise_link_data['item_url'], merchandise_link.item_url
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal merchandise_link_data["book_id"], merchandise_link.book_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/books/#{@book.id}/merchandise_links", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      merchandise_link_ids_returned = response.parsed_body.dig("data").map { |merchandise_link| merchandise_link.dig("attributes", "id") }
      assert_includes(merchandise_link_ids_returned, @merchandise_link.id)

      # But not returning other people's resources.
      assert_not_includes(merchandise_link_ids_returned, @other_merchandise_links[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/merchandise_links/#{@merchandise_link.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/merchandise_links/#{@merchandise_link.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      merchandise_link_data = Api::V1::MerchandiseLinkSerializer.new(build(:merchandise_link, book: nil)).serializable_hash.dig(:data, :attributes)
      merchandise_link_data.except!(:id, :book_id, :created_at, :updated_at)

      post "/api/v1/books/#{@book.id}/merchandise_links",
        params: merchandise_link_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/books/#{@book.id}/merchandise_links",
        params: merchandise_link_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/merchandise_links/#{@merchandise_link.id}", params: {
        access_token: access_token,
        seller_name: 'Alternative String Value',
        item_url: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @merchandise_link.reload
      assert_equal @merchandise_link.seller_name, 'Alternative String Value'
      assert_equal @merchandise_link.item_url, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/merchandise_links/#{@merchandise_link.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("MerchandiseLink.count", -1) do
        delete "/api/v1/merchandise_links/#{@merchandise_link.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/merchandise_links/#{@merchandise_link.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
