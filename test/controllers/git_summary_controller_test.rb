require 'test_helper'

class GitSummaryControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get git_summary_show_url
    assert_response :success
  end

end
