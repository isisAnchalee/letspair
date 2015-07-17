class ChangeUsernameToName < ActiveRecord::Migration
  def change
    remove_column :users, :username
    add_column :users, :name, :string, null: false
    add_index :users, :name
  end
end
