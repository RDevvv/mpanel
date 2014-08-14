class AddFacebookDetailsToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :facebook_id, :integer
    add_column :brands, :facebook_username, :string
    add_column :brands, :facebook_likes_count, :string
  end
end
