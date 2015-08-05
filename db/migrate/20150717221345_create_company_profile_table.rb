class CreateCompanyProfileTable < ActiveRecord::Migration
  def change
    create_table :company_profiles do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :location
    end

    add_index :company_profiles, :name
  end
end



