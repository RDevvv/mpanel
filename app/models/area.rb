class Area < ActiveRecord::Base
  attr_accessible :area_name, :city_id, :pincode, :latitude, :longitude, :city_name
  has_many :accounts, :dependent => :destroy
  has_many :outlets, :dependent => :destroy
  belongs_to :city
  geocoded_by :area_name   # can also be an IP address
	after_validation :geocode, :if => :address_changed?
	
end
