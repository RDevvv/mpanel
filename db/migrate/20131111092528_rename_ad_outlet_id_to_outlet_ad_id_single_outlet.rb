class RenameAdOutletIdToOutletAdIdSingleOutlet < ActiveRecord::Migration
  def up
  	rename_column :single_code_specific_outlets, :ad_outlet_id, :outlet_ad_id
  end

  def down
  	rename_column :single_code_specific_outlets, :outlet_ad_id, :ad_outlet_id
  end
end
