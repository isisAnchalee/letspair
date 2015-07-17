class FixIsCompany < ActiveRecord::Migration
  def change
    remove_column :users, :is_company
    add_column :users, :is_company, :boolean, default: false
  end
end
