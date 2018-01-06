require 'test_helper'

class MonitoringControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get monitoring_show_url
    assert_response :success
  end

end
