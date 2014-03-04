class CreateCuisineTypes < ActiveRecord::Migration
  def change
    create_table :cuisine_types do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end

    add_index :cuisine_types, :name, unique: true
    add_index :cuisine_types, :slug, unique: true
  end
end
