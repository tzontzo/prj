class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :project, index: true
      t.string :title,index: true
      t.string :details,index: true
      t.integer :time_worked
      t.datetime :started_at
      t.datetime :paused_at
      t.datetime :ended_at
      t.string :status
      t.timestamps null: false
    end
  end
end
