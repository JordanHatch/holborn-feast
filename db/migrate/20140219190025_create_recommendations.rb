class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :user_id, null: false
      t.integer :eatery_id, null: false
      t.timestamps
    end
    add_index :recommendations, [:user_id, :eatery_id], unique: true
  end
end
