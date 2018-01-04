require 'test_helper'

class TaskRecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get task_records_show_url
    assert_response :success
  end

end
