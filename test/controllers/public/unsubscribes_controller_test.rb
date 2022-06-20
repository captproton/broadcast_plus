require "test_helper"

class Public::UnsubscribesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_unsubscribes_show_url
    assert_response :success
  end
end
