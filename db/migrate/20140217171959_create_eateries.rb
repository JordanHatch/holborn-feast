class CreateEateries < ActiveRecord::Migration
  def change
    create_table :eateries do |t|
      t.string :name
      t.string :slug, unique: true
      t.float :lat
      t.float :lon
      t.timestamps
    end
  end
end
