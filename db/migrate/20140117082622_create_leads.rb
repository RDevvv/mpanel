class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :source
      t.string :email
      t.integer :mobile_number, :limit => 8
      t.string :first_name
      t.string :last_name
      t.string :target
      t.string :company_name
      t.string :designation
      t.boolean :subscribe_email_updates

      t.timestamps
    end
  end
end
