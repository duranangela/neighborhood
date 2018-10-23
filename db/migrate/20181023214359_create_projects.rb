class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :photo
      t.integer :project_owner_id

      t.timestamps
    end
  end
end
