require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "renders the phase 0 foundation home page" do
    get root_url

    assert_response :success
    assert_includes response.body, "May December Men's Club"
  end
end
