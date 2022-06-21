require "test_helper"

class Public::SubscribesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_subscribes_new_url
    assert_response :success
  end
end
