class OutletVersion < ActiveRecord::Base
  attr_accessible :address, :area_id, :account_brand_id, :daily_cap, :email_id, :is_active, :is_deleted, :is_verified, :latitude, :longitude, :mobile_country_id, :mobile_number, :outlet_alias, :outlet_id, :outlet_key, :outlet_name, :outlet_type_id, :payment_value_id, :phone_number, :version_id
  belongs_to :outlet
end
