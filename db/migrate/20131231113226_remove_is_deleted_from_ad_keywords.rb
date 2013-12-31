class RemoveIsDeletedFromAdKeywords < ActiveRecord::Migration
  def up
  	remove_column :ad_keywords, :is_deleted
  end

  def down
  	add_column :ad_keywords, :is_deleted, :boolean
  end
end
