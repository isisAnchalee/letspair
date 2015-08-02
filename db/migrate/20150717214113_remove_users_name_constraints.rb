class RemoveUsersNameConstraints < ActiveRecord::Migration
  def change
    remove_column :users, :first_name
    add_column :users, :first_name, :string, null: false

    remove_column :users, :last_name
    add_column :users, :last_name, :string, null: false

    remove_column :users, :is_company
    add_column :users, :is_company, :boolean, null: false
  end
end
