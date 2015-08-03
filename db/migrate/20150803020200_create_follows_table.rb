class CreateFollowsTable < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :followed, polymorphic: true, index: true, null: false
      t.integer :follower_id, index: true, null: false
      t.timestamps
    end
  end
end
