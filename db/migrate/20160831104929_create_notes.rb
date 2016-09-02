class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :user, index: true
      t.string :note_type
      t.string :content
      t.timestamps null: false
    end
  end
end
