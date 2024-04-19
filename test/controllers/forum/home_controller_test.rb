require "test_helper"

class Forum::HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get forum_home_index_url
    assert_response :success
  end
end
