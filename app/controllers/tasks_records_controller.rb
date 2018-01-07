class TasksRecordsController < ApplicationController

  def show
    @tasks_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(name: 'Todo tasks', yAxis: 0, data: TasksRecord.where( stock_line: false ).pluck( :todo_count ) )
      f.yAxis [ {title: {text: 'Todo tasks', margin: 70} } ]
      f.xAxis( categories:  TasksRecord.where( stock_line: false ).pluck( :created_at ).map{ |e| e.strftime( '%F' ) } )
      # f.responsive( rules: [ { condition: { maxWidth: 500 } } ] )
    end
  end

  def data

    # pp TasksRecord.all

    last_closed_tasks_count = TasksRecord.where( stock_line: true ).first.done_count
    data = []

    TasksRecord.where( stock_line: false ).order( 'id' ).all.each do |task_record|
      data << { 'DoneCount' => task_record.done_count - last_closed_tasks_count, 'Date' => task_record.created_at.strftime( '%F' ) }
      last_closed_tasks_count = task_record.done_count
    end

    render json: data
  end

end
