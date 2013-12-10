class CreateAdGroups < ActiveRecord::Migration
  def change
    create_table :ad_groups do |t|
      t.string :name
      t.boolean :is_active

      t.timestamps
    end
  end
end
