require 'test_helper'

class TaskRecordsControllerTest < ActionDispatch::IntegrationTest

  def setup
    create( :tasks_record )
    create( :tasks_record, stock_line: true, done_count: 8 )
  end

  test 'should get show' do
    get tasks_records_show_url
    assert_response :success
  end

  test 'should get data' do
    get tasks_records_show_url
    assert_response :success
    # assert_equal '[{"DoneCount":2,"Date":"2018-01-05"}]', @response.body
  end

end
