class OutletVersion < ActiveRecord::Base
  attr_accessible :address, :area_id, :account_brand_id, :email_id, :is_active, :is_deleted, :is_verified, :latitude, :longitude, :mobile_country_id, :mobile_number, :outlet_id, :outlet_key, :outlet_type_id, :phone_number, :outlet_views, :outlet_calls, :outlet_impressions
  belongs_to :outlet
end
