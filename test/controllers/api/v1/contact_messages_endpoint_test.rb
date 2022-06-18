require "test_helper"
require "controllers/api/test"

class Api::V1::ContactMessagesEndpointTest < Api::Test
  include Devise::Test::IntegrationHelpers

    def setup
      # See `test/controllers/api/test.rb` for common set up for API tests.
      super

      @site = create(:site, team: @team)
@contact_message = create(:contact_message, site: @site)
      @other_contact_messages = create_list(:contact_message, 3)
    end

    # This assertion is written in such a way that new attributes won't cause the tests to start failing, but removing
    # data we were previously providing to users _will_ break the test suite.
    def assert_proper_object_serialization(contact_message_data)
      # Fetch the contact_message in question and prepare to compare it's attributes.
      contact_message = ContactMessage.find(contact_message_data["id"])

      assert_equal contact_message_data['email'], contact_message.email
      assert_equal contact_message_data['first_name'], contact_message.first_name
      assert_equal contact_message_data['last_name'], contact_message.last_name
      assert_equal contact_message_data['phone'], contact_message.phone
      assert_equal contact_message_data['subject'], contact_message.subject
      assert_equal contact_message_data['body'], contact_message.body
      # 🚅 super scaffolding will insert new fields above this line.

      assert_equal contact_message_data["site_id"], contact_message.site_id
    end

    test "index" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/sites/#{@site.id}/contact_messages", params: {access_token: access_token}
      assert_response :success

      # Make sure it's returning our resources.
      contact_message_ids_returned = response.parsed_body.dig("data").map { |contact_message| contact_message.dig("attributes", "id") }
      assert_includes(contact_message_ids_returned, @contact_message.id)

      # But not returning other people's resources.
      assert_not_includes(contact_message_ids_returned, @other_contact_messages[0].id)

      # And that the object structure is correct.
      assert_proper_object_serialization response.parsed_body.dig("data").first.dig("attributes")
    end

    test "show" do
      # Fetch and ensure nothing is seriously broken.
      get "/api/v1/contact_messages/#{@contact_message.id}", params: {access_token: access_token}
      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      get "/api/v1/contact_messages/#{@contact_message.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "create" do
      # Use the serializer to generate a payload, but strip some attributes out.
      contact_message_data = Api::V1::ContactMessageSerializer.new(build(:contact_message, site: nil)).serializable_hash.dig(:data, :attributes)
      contact_message_data.except!(:id, :site_id, :created_at, :updated_at)

      post "/api/v1/sites/#{@site.id}/contact_messages",
        params: contact_message_data.merge({access_token: access_token})

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # Also ensure we can't do that same action as another user.
      post "/api/v1/sites/#{@site.id}/contact_messages",
        params: contact_message_data.merge({access_token: another_access_token})
      # TODO Why is this returning forbidden instead of the specific "Not Found" we get everywhere else?
      assert_response :forbidden
    end

    test "update" do
      # Post an attribute update ensure nothing is seriously broken.
      put "/api/v1/contact_messages/#{@contact_message.id}", params: {
        access_token: access_token,
        email: 'Alternative String Value',
        first_name: 'Alternative String Value',
        last_name: 'Alternative String Value',
        phone: 'Alternative String Value',
        subject: 'Alternative String Value',
        body: 'Alternative String Value',
        # 🚅 super scaffolding will also insert new fields above this line.
      }

      assert_response :success

      # Ensure all the required data is returned properly.
      assert_proper_object_serialization response.parsed_body.dig("data", "attributes")

      # But we have to manually assert the value was properly updated.
      @contact_message.reload
      assert_equal @contact_message.email, 'Alternative String Value'
      assert_equal @contact_message.first_name, 'Alternative String Value'
      assert_equal @contact_message.last_name, 'Alternative String Value'
      assert_equal @contact_message.phone, 'Alternative String Value'
      assert_equal @contact_message.subject, 'Alternative String Value'
      assert_equal @contact_message.body, 'Alternative String Value'
      # 🚅 super scaffolding will additionally insert new fields above this line.

      # Also ensure we can't do that same action as another user.
      put "/api/v1/contact_messages/#{@contact_message.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end

    test "destroy" do
      # Delete and ensure it actually went away.
      assert_difference("ContactMessage.count", -1) do
        delete "/api/v1/contact_messages/#{@contact_message.id}", params: {access_token: access_token}
        assert_response :success
      end

      # Also ensure we can't do that same action as another user.
      delete "/api/v1/contact_messages/#{@contact_message.id}", params: {access_token: another_access_token}
      assert_response_specific_not_found
    end
end
