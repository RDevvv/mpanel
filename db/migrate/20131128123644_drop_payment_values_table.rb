class DropPaymentValuesTable < ActiveRecord::Migration
  def up
  	drop_table :payment_values
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
