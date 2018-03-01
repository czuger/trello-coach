require 'test_helper'

class DailiesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get dailies_show_url
    assert_response :success
  end

end
