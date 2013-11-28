class Outlet < ActiveRecord::Base
  attr_accessible :account_brand_id, :address, :area_id, :email_id, :is_active, :is_verified
  attr_accessible :latest_version_id, :latitude, :longitude, :mobile_country_id, :mobile_number
  attr_accessible :outlet_key, :outlet_type_id, :phone_number, :outlet_views, :outlet_calls, :outlet_impressions

  has_many :outlet_versions
  belongs_to :area
  belongs_to :account_brand
  belongs_to :payment_value
  belongs_to :outlet_type
end
