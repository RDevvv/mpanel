class CreateOutletTypes < ActiveRecord::Migration
  def change
    create_table :outlet_types do |t|
      t.string :outlet_type_name

      t.timestamps
    end
  end
end
