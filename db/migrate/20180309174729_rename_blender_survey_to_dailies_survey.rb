class RenameBlenderSurveyToDailiesSurvey < ActiveRecord::Migration[5.1]
  def change
    rename_table :blender_surveys, :dailies_surveys
  end
end
