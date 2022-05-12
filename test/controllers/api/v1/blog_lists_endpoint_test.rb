require "test_helper"
require "controllers/api/test"

class Api::V1::BlogListsEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@blog_list = create(:blog_list, site: @site)
      @other_blog_lists = create_list(:blog_list, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(blog_list_data)
      # Fetch the blog_list in question and prepare to compare it's attributes.
      blog_list = BlogList.find(blog_list_data["id"])

      assert_equal blog_list_data['title'], blog_list.title
      assert_equal blog_list_data['description'], blog_list.description
      assert_equal blog_list_data['tag_ids'], blog_list.tag_ids
      assert_equal blog_list_data['blog_entry_ids'], blog_list.blog_entry_ids
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal blog_list_data["site_id"], blog_list.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/blog_lists", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      blog_list_ids_returned = response.parsed_body.dig("data").map { |blog_list| blog_list.dig("attributes", "id") }
      assert_includes(blog_list_ids_returned, @blog_list.id)

      # But not returning other people's resources.
      assert_not_includes(blog_list_ids_returned, @other_blog_lists[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/blog_lists/#{@blog_list.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/blog_lists/#{@blog_list.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      blog_list_data = Api::V1::BlogListSerializer.new(build(:blog_list, site: nil)).serializable_hash.dig(:data, :attributes)
      blog_list_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/blog_lists",
        params: blog_list_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/blog_lists",
        params: blog_list_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/blog_lists/#{@blog_list.id}", params: {
        access_token: access_token,
        title: 'Alternative String Value',
        description: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @blog_list.reload
      assert_equal @blog_list.title, 'Alternative String Value'
      assert_equal @blog_list.description, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/blog_lists/#{@blog_list.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("BlogList.count", -1) do
        delete "/api/v1/blog_lists/#{@blog_list.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/blog_lists/#{@blog_list.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
