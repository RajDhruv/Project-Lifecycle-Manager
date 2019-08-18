class AddDeveloperCountToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :developer_count, :integer
  end
end
