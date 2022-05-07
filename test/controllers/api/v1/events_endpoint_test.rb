require "test_helper"
require "controllers/api/test"

class Api::V1::EventsEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@event = create(:event, site: @site)
      @other_events = create_list(:event, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(event_data)
      # Fetch the event in question and prepare to compare it's attributes.
      event = Event.find(event_data["id"])

      assert_equal event_data['title'], event.title
      assert_equal event_data['start_date'], event.start_date
      assert_equal event_data['more_info_url'], event.more_info_url
      assert_equal event_data['location'], event.location
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal event_data["site_id"], event.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/events", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      event_ids_returned = response.parsed_body.dig("data").map { |event| event.dig("attributes", "id") }
      assert_includes(event_ids_returned, @event.id)

      # But not returning other people's resources.
      assert_not_includes(event_ids_returned, @other_events[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/events/#{@event.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/events/#{@event.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      event_data = Api::V1::EventSerializer.new(build(:event, site: nil)).serializable_hash.dig(:data, :attributes)
      event_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/events",
        params: event_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/events",
        params: event_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/events/#{@event.id}", params: {
        access_token: access_token,
        title: 'Alternative String Value',
        more_info_url: 'Alternative String Value',
        location: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @event.reload
      assert_equal @event.title, 'Alternative String Value'
      assert_equal @event.more_info_url, 'Alternative String Value'
      assert_equal @event.location, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/events/#{@event.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("Event.count", -1) do
        delete "/api/v1/events/#{@event.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/events/#{@event.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
