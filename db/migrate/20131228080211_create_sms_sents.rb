class CreateSmsSents < ActiveRecord::Migration
  def change
    create_table :sms_sents do |t|
      t.string :text
      t.integer :is_sent
      t.references :customer
      t.references :ad_promocode

      t.timestamps
    end
    add_index :sms_sents, :customer_id
    add_index :sms_sents, :ad_promocode_id
  end
end
