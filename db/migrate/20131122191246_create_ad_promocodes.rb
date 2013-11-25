class CreateAdPromocodes < ActiveRecord::Migration
  def change
    create_table :ad_promocodes do |t|
      t.string :set_name
      t.string :promocode
      t.integer :ad_id
      t.float :cap
      t.float :usage
      t.boolean :is_used,:default=>false

      t.timestamps
    end
  end
end
