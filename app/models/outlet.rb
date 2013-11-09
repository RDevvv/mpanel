class Outlet < ActiveRecord::Base
  attr_accessible :account_brand_id, :address, :area_id, :daily_cap, :email_id, :is_active, :is_verified, :latest_version_id, :latitude, :longitude, :mobile_country_id, :mobile_number, :outlet_alias, :outlet_key, :outlet_name, :outlet_type_id, :payment_value_id, :phone_number
  belongs_to :area
  belongs_to :account_brand
end
