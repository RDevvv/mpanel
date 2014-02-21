class CreateCustomerFeedbacks < ActiveRecord::Migration
  def change
    create_table :customer_feedbacks do |t|
      t.string :email
      t.string :link
      t.text :feedback
      t.references :customer

      t.timestamps
    end
    add_index :customer_feedbacks, :customer_id
  end
end
