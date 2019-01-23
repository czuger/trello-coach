class TasksRecordsController < ApplicationController

  def show
    tr = TasksRecord.where( stock_line: false ).where( 'created_at > ?', Time.now - 6.month )

    @tasks_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(name: 'Todo tasks', yAxis: 0, data: tr.pluck( :todo_count ) )
      f.yAxis [ {title: {text: 'Todo tasks', margin: 70} } ]
      f.xAxis( categories: tr.pluck( :created_at ).map{ |e| e.strftime( '%F' ) } )
      # f.responsive( rules: [ { condition: { maxWidth: 500 } } ] )
    end
    set_data
  end

  private

  def set_data

    # pp TasksRecord.all

    tr = TasksRecord.where( stock_line: true ).where( 'created_at > ?', DateTime.now.beginning_of_year )

    last_closed_tasks_count = tr.first
    last_closed_tasks_count = last_closed_tasks_count ? last_closed_tasks_count.done_count : 0

    tasks_data = []

    tr.order( 'id' ).all.each do |task_record|
      tasks_data << { 'Count' => task_record.done_count - last_closed_tasks_count, 'Date' => task_record.created_at.strftime( '%F' ) }
      last_closed_tasks_count = task_record.done_count
    end

    @tasks_data = tasks_data.to_json
  end

end
