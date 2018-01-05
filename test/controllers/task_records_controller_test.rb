require 'test_helper'

class TaskRecordsControllerTest < ActionDispatch::IntegrationTest

  def setup
    FactoryBot.find_definitions
    create( :tasks_record )
    create( :tasks_record, stock_line: false )
  end

  test 'should get show' do
    get tasks_records_show_url
    assert_response :success
  end

  # test 'should get data' do
  #   get tasks_records_data_url
  #   assert_response :success
  # end

end
