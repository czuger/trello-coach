class CreateBlenderSurveys < ActiveRecord::Migration[5.1]
  def change
    create_table :blender_surveys do |t|
      t.boolean :blender_task_done, null: false, default: false

      t.timestamps
    end
  end
end
