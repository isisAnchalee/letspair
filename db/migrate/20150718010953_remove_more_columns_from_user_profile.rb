class RemoveMoreColumnsFromUserProfile < ActiveRecord::Migration
  def change
    remove_column :user_profiles, :last_name
    remove_column :user_profiles, :email
  end
end
