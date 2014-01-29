class CreateMissedCalls < ActiveRecord::Migration
  def change
    create_table :missed_calls do |t|
      t.references :campaign
      t.string :call_sid
      t.integer :from, :limit => 4
      t.integer :to, :limit => 4
      t.boolean :is_valid

      t.timestamps
    end
    add_index :missed_calls, :campaign_id
  end
end
