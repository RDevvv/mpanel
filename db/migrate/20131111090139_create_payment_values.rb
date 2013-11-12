class CreatePaymentValues < ActiveRecord::Migration
  def change
    create_table :payment_values do |t|
      t.float :catchment_radius
      t.integer :currency_id
      t.float :value

      t.timestamps
    end
  end
end
