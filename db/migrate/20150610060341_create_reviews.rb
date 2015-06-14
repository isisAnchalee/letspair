class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :reviewer_id, null: false
      t.integer :reviewed_id, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.integer :rating, null: false
      t.integer :project_id, null: false

      t.timestamps null: false
    end
  end
end
