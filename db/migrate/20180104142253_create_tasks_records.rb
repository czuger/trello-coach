class CreateTasksRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks_records do |t|

      t.integer :done_count, null: false
      t.integer :todo_count, null: false
      t.boolean :stock_line, null: false, default: false

      t.timestamps
    end
  end
end
