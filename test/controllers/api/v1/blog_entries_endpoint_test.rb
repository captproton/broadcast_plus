require "test_helper"
require "controllers/api/test"

class Api::V1::BlogEntriesEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@blog_entry = create(:blog_entry, site: @site)
      @other_blog_entries = create_list(:blog_entry, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(blog_entry_data)
      # Fetch the blog_entry in question and prepare to compare it's attributes.
      blog_entry = BlogEntry.find(blog_entry_data["id"])

      assert_equal blog_entry_data['title'], blog_entry.title
      assert_equal blog_entry_data['pinned_value'], blog_entry.pinned_value
      assert_equal DateTime.parse(blog_entry_data['publish_at']), blog_entry.publish_at
      assert_equal blog_entry_data['seo_title'], blog_entry.seo_title
      assert_equal blog_entry_data['seo_description'], blog_entry.seo_description
      assert_equal blog_entry_data['hero_image'], blog_entry.hero_image
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal blog_entry_data["site_id"], blog_entry.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/blog_entries", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      blog_entry_ids_returned = response.parsed_body.dig("data").map { |blog_entry| blog_entry.dig("attributes", "id") }
      assert_includes(blog_entry_ids_returned, @blog_entry.id)

      # But not returning other people's resources.
      assert_not_includes(blog_entry_ids_returned, @other_blog_entries[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/blog_entries/#{@blog_entry.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/blog_entries/#{@blog_entry.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      blog_entry_data = Api::V1::BlogEntrySerializer.new(build(:blog_entry, site: nil)).serializable_hash.dig(:data, :attributes)
      blog_entry_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/blog_entries",
        params: blog_entry_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/blog_entries",
        params: blog_entry_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/blog_entries/#{@blog_entry.id}", params: {
        access_token: access_token,
        title: 'Alternative String Value',
        pinned_value: 'Alternative String Value',
        seo_title: 'Alternative String Value',
        seo_description: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @blog_entry.reload
      assert_equal @blog_entry.title, 'Alternative String Value'
      assert_equal @blog_entry.pinned_value, 'Alternative String Value'
      assert_equal @blog_entry.seo_title, 'Alternative String Value'
      assert_equal @blog_entry.seo_description, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/blog_entries/#{@blog_entry.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("BlogEntry.count", -1) do
        delete "/api/v1/blog_entries/#{@blog_entry.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/blog_entries/#{@blog_entry.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
