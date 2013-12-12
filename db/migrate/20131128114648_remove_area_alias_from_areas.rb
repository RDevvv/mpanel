class RemoveAreaAliasFromAreas < ActiveRecord::Migration
  def up
    remove_column :areas, :area_alias
  end

  def down
    add_column :areas, :area_alias, :string
  end
end
