class CreateIncentives < ActiveRecord::Migration
  def change
    create_table :incentives do |t|
      t.string :name
      t.string :sms_text
      t.datetime :expiry_date
      t.boolean :is_active

      t.timestamps
    end
  end
end
