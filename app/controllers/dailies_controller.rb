class DailiesController < ApplicationController
  def show
    blender_data = []

    BlenderSurvey.order( 'id' ).each do |blender_survey|
      blender_data << { 'Count' => blender_survey.blender_task_done ? 1 : 0, 'Date' => blender_survey.created_at.strftime( '%F' ) }
    end

    @blender_data = blender_data.to_json
  end
end
