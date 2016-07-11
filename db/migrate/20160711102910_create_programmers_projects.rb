class CreateProgrammersProjects < ActiveRecord::Migration
  def change
    create_table :programmers_projects do |t|
      t.references :programmer
      t.references :project
    end
    add_index :programmers_projects, [:programmer_id, :project_id]
    add_index :programmers_projects, :project_id
  end
end
