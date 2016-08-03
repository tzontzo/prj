class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :project, index: true
      t.string :title,index: true
      t.string :details,index: true
      t.timestamps null: false
    end
  end
end
