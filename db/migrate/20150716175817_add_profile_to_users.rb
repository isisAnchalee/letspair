class AddProfileToUsers < ActiveRecord::Migration
  def change
    create_table(:user_profiles) do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.integer :user_id, null: false
      t.string :short_tag_line
      t.text :description
      t.text :work_history
      t.timestamps
    end

    add_index :user_profiles, :user_id
    add_index :user_profiles, :email
  end
end
