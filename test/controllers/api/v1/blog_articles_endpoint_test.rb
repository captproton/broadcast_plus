require "test_helper"
require "controllers/api/test"

class Api::V1::BlogArticlesEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @blog_entry = create(:blog_entry, team: @team)
@blog_article = create(:blog_article, blog_entry: @blog_entry)
      @other_blog_articles = create_list(:blog_article, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(blog_article_data)
      # Fetch the blog_article in question and prepare to compare it's attributes.
      blog_article = BlogArticle.find(blog_article_data["id"])

      assert_equal blog_article_data['byline'], blog_article.byline
      assert_equal blog_article_data['pinned_value'], blog_article.pinned_value
      assert_equal blog_article_data['name'], blog_article.name
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal blog_article_data["blog_entry_id"], blog_article.blog_entry_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/blog_entries/#{@blog_entry.id}/blog_articles", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      blog_article_ids_returned = response.parsed_body.dig("data").map { |blog_article| blog_article.dig("attributes", "id") }
      assert_includes(blog_article_ids_returned, @blog_article.id)

      # But not returning other people's resources.
      assert_not_includes(blog_article_ids_returned, @other_blog_articles[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/blog_articles/#{@blog_article.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/blog_articles/#{@blog_article.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      blog_article_data = Api::V1::BlogArticleSerializer.new(build(:blog_article, blog_entry: nil)).serializable_hash.dig(:data, :attributes)
      blog_article_data.except!(:id, :blog_entry_id, :created_at, :updated_at)

      post "/api/v1/blog_entries/#{@blog_entry.id}/blog_articles",
        params: blog_article_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/blog_entries/#{@blog_entry.id}/blog_articles",
        params: blog_article_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/blog_articles/#{@blog_article.id}", params: {
        access_token: access_token,
        byline: 'Alternative String Value',
        pinned_value: 'Alternative String Value',
        name: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @blog_article.reload
      assert_equal @blog_article.byline, 'Alternative String Value'
      assert_equal @blog_article.pinned_value, 'Alternative String Value'
      assert_equal @blog_article.name, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/blog_articles/#{@blog_article.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("BlogArticle.count", -1) do
        delete "/api/v1/blog_articles/#{@blog_article.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/blog_articles/#{@blog_article.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
