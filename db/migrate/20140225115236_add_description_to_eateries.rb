class AddDescriptionToEateries < ActiveRecord::Migration
  def change
    add_column :eateries, :description, :text
  end
end
