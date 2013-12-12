class DropPromocodeTypesTable < ActiveRecord::Migration
  def up
  	drop_table :promocode_types
  end

  def down
  	aise ActiveRecord::IrreversibleMigration
  end
end
