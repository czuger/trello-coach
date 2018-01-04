class CreateTaskRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :task_records do |t|
      t.string :list_name, null: false
      t.integer :cards_count, null: false

      t.timestamps
    end
  end
end
