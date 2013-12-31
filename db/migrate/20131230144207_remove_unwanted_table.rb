class RemoveUnwantedTable < ActiveRecord::Migration
  def up
    drop_table :outlet_versions if ActiveRecord::Base.connection.table_exists? 'outlet_versions'
    drop_table :ad_versions if ActiveRecord::Base.connection.table_exists? 'ad_versions'
    drop_table :area_pincodes if ActiveRecord::Base.connection.table_exists? 'area_pincodes'
  end

  def down
  end
end
