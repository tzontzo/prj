class CreateTaskUsers < ActiveRecord::Migration
  def change
    create_table :task_users do |t|
      t.references :task, index: true
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
