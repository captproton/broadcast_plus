require "test_helper"
require "controllers/api/test"

class Api::V1::PublisherAccountsEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@publisher_account = create(:publisher_account, site: @site)
      @other_publisher_accounts = create_list(:publisher_account, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(publisher_account_data)
      # Fetch the publisher_account in question and prepare to compare it's attributes.
      publisher_account = PublisherAccount.find(publisher_account_data["id"])

      assert_equal publisher_account_data['name'], publisher_account.name
      assert_equal publisher_account_data['url'], publisher_account.url
      assert_equal publisher_account_data['font_awesome_class'], publisher_account.font_awesome_class
      assert_equal publisher_account_data['network_kind'], publisher_account.network_kind
      assert_equal publisher_account_data['blurb'], publisher_account.blurb
      assert_equal publisher_account_data['svg_logo'], publisher_account.svg_logo
      assert_equal publisher_account_data['svg_logo_style'], publisher_account.svg_logo_style
      assert_equal publisher_account_data['frontpage_ranking'], publisher_account.frontpage_ranking
      assert_equal publisher_account_data['sidebar_ranking'], publisher_account.sidebar_ranking
      assert_equal publisher_account_data['footer_ranking'], publisher_account.footer_ranking
      assert_equal publisher_account_data['podcast_ranking'], publisher_account.podcast_ranking
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal publisher_account_data["site_id"], publisher_account.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/publisher_accounts", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      publisher_account_ids_returned = response.parsed_body.dig("data").map { |publisher_account| publisher_account.dig("attributes", "id") }
      assert_includes(publisher_account_ids_returned, @publisher_account.id)

      # But not returning other people's resources.
      assert_not_includes(publisher_account_ids_returned, @other_publisher_accounts[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/publisher_accounts/#{@publisher_account.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/publisher_accounts/#{@publisher_account.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      publisher_account_data = Api::V1::PublisherAccountSerializer.new(build(:publisher_account, site: nil)).serializable_hash.dig(:data, :attributes)
      publisher_account_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/publisher_accounts",
        params: publisher_account_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/publisher_accounts",
        params: publisher_account_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/publisher_accounts/#{@publisher_account.id}", params: {
        access_token: access_token,
        name: 'Alternative String Value',
        url: 'Alternative String Value',
        font_awesome_class: 'Alternative String Value',
        network_kind: 'Alternative String Value',
        blurb: 'Alternative String Value',
        svg_logo: 'Alternative String Value',
        svg_logo_style: 'Alternative String Value',
        frontpage_ranking: 'Alternative String Value',
        sidebar_ranking: 'Alternative String Value',
        footer_ranking: 'Alternative String Value',
        podcast_ranking: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @publisher_account.reload
      assert_equal @publisher_account.name, 'Alternative String Value'
      assert_equal @publisher_account.url, 'Alternative String Value'
      assert_equal @publisher_account.font_awesome_class, 'Alternative String Value'
      assert_equal @publisher_account.network_kind, 'Alternative String Value'
      assert_equal @publisher_account.blurb, 'Alternative String Value'
      assert_equal @publisher_account.svg_logo, 'Alternative String Value'
      assert_equal @publisher_account.svg_logo_style, 'Alternative String Value'
      assert_equal @publisher_account.frontpage_ranking, 'Alternative String Value'
      assert_equal @publisher_account.sidebar_ranking, 'Alternative String Value'
      assert_equal @publisher_account.footer_ranking, 'Alternative String Value'
      assert_equal @publisher_account.podcast_ranking, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/publisher_accounts/#{@publisher_account.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("PublisherAccount.count", -1) do
        delete "/api/v1/publisher_accounts/#{@publisher_account.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/publisher_accounts/#{@publisher_account.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
