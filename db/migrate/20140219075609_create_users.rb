class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.string :oauth_provider_uid, unique: true
      t.string :image_url

      t.timestamps
    end
  end
end
