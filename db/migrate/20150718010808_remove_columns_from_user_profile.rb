class RemoveColumnsFromUserProfile < ActiveRecord::Migration
  def change
    remove_column :user_profiles, :first_name, :last_name, :email
  end
end
