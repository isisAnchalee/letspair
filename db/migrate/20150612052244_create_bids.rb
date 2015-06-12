class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :project_id,  null: false
      t.integer :price,       null: false
      t.integer :bidder_id,   null: false
      t.text :content,        null: false

      t.timestamps null: false
    end
  end
end
