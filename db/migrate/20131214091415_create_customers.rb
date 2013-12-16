class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :uuid
      t.string :platform
      t.string :browser
      t.string :browser_version

      t.timestamps
    end
  end
end
