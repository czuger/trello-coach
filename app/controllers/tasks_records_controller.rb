class TasksRecordsController < ApplicationController
  def show
  end

  def data

    last_closed_tasks_count = TasksRecord.where( stock_line: true ).first.done_count
    data = []

    TasksRecord.where( stock_line: false ).order( 'id' ).all.each do |task_record|
      data << { 'DoneCount' => task_record.done_count - last_closed_tasks_count, 'Date' => task_record.created_time.strftime( '%F' ) }
      last_closed_tasks_count = task_record.done_count
    end

    render json: data
  end

end
