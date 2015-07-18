class AddUserIdToCompanyProfile < ActiveRecord::Migration
  def change
    add_column :company_profiles, :user_id, :integer, null: false

  end
end
