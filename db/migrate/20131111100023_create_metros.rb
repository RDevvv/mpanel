class CreateMetros < ActiveRecord::Migration
  def change
    create_table :metros do |t|
      t.string :country_id
      t.string :metro_name
      t.string :metro_long_name
      t.string :metro_code

      t.timestamps
    end
  end
end
