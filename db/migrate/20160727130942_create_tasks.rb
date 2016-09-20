class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :creator, index: true
      t.references :assigned_user, index: true
      t.references :project, index: true
      t.string :title,index: true
      t.string :details,index: true
      t.integer :time_worked
      t.datetime :started_at
      t.datetime :pause_started_at
      t.datetime :pause_ended_at
      t.datetime :ended_at
      t.string :status
      t.text :interval
      t.timestamps null: false
    end
  end
end
