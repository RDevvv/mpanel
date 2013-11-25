class Outlet < ActiveRecord::Base
  attr_accessible :account_brand_id, :address, :area_id, :daily_cap, :email_id, :is_active, :is_verified, :outlet_name, :latest_version_id, :latitude, :longitude, :mobile_country_id, :mobile_number, :outlet_alias, :outlet_key, :outlet_type_id, :payment_value_id, :phone_number
  has_many :outlet_ads, :dependent => :destroy
  has_many :ads, :through => :outlet_ads  
  has_many :outlet_versions
  belongs_to :area
  belongs_to :account_brand
  belongs_to :payment_value
  belongs_to :outlet_type
end
