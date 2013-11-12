class CreatePromocodeTypes < ActiveRecord::Migration
  def change
    create_table :promocode_types do |t|
      t.string :promocode_type

      t.timestamps
    end
  end
end
