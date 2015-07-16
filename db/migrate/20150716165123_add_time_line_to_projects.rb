class AddTimeLineToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :time_line, :integer, null: false
    add_index :projects, :time_line
  end
end
