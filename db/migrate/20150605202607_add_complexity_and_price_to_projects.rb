class AddComplexityAndPriceToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :complexity, :integer
    add_column :projects, :price, :integer

    add_index :projects, :complexity
  	add_index :projects, :price
  end
end
