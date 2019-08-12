class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.integer :admin
      t.integer :lock_version

      t.timestamps
    end
  end
end
