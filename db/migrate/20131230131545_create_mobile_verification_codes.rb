class CreateMobileVerificationCodes < ActiveRecord::Migration
  def change
    create_table :mobile_verification_codes do |t|
      t.string :verification_code
      t.references :customer

      t.timestamps
    end
    add_index :mobile_verification_codes, :customer_id
  end
end
