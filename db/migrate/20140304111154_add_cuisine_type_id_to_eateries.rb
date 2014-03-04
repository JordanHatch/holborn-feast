class AddCuisineTypeIdToEateries < ActiveRecord::Migration
  def change
    add_column :eateries, :cuisine_type_id, :integer
  end
end
