class AddIsAdToSmsSents < ActiveRecord::Migration
  def change
    add_column :sms_sents, :is_ad, :boolean, :default => false
  end
end
