class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :country_id
      t.string :state_name
      t.string :state_code
      t.string :state_code

      t.timestamps
    end
  end
end
