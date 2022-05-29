require "test_helper"

class Public::BlogEntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_blog_entries_index_url
    assert_response :success
  end

  test "should get show" do
    get public_blog_entries_show_url
    assert_response :success
  end

  test "should get cosmo" do
    get public_blog_entries_cosmo_url
    assert_response :success
  end

  test "should get houston" do
    get public_blog_entries_houston_url
    assert_response :success
  end
end
