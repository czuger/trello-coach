class TasksRecordsController < ApplicationController

  def show
    @tasks_chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.series(name: 'Todo tasks', yAxis: 0, data: TasksRecord.where( stock_line: false ).pluck( :todo_count ) )
      f.yAxis [ {title: {text: 'Todo tasks', margin: 70} } ]
      f.xAxis( categories:  TasksRecord.where( stock_line: false ).pluck( :created_at ).map{ |e| e.strftime( '%F' ) } )
      # f.responsive( rules: [ { condition: { maxWidth: 500 } } ] )
    end
    set_data
  end

  private

  def set_data

    # pp TasksRecord.all

    last_closed_tasks_count = TasksRecord.where( stock_line: true ).first.done_count
    tasks_data = []
    blender_data = []

    TasksRecord.where( stock_line: false ).order( 'id' ).all.each do |task_record|
      tasks_data << { 'DoneCount' => task_record.done_count - last_closed_tasks_count, 'Date' => task_record.created_at.strftime( '%F' ) }
      last_closed_tasks_count = task_record.done_count
    end

    BlenderSurvey.order( 'id' ).each do |blender_survey|
      blender_data << { 'Done' => blender_survey.blender_task_done ? 1 : 0, 'Date' => blender_survey.created_at.strftime( '%F' ) }
    end

    @tasks_data = tasks_data.to_json
    @blender_data = blender_data.to_json
  end

end
