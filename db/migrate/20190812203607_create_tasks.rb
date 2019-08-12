class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :description
      t.integer :lock_version
      t.belongs_to :user, foreign_key: true
      t.belongs_to :project, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
