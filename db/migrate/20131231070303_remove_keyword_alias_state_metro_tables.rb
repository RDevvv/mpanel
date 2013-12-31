class RemoveKeywordAliasStateMetroTables < ActiveRecord::Migration
  def up
  	drop_table :keyword_aliases if ActiveRecord::Base.connection.table_exists? 'keyword_aliases'
  	drop_table :states if ActiveRecord::Base.connection.table_exists? 'states'
  	drop_table :metros if ActiveRecord::Base.connection.table_exists? 'metros'
  end

  def down
  end
end
