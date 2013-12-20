class Area < ActiveRecord::Base
  attr_accessible :area_name, :city_id, :pincode, :latitude, :longitude, :city_name
  has_many :accounts, :dependent => :destroy
  has_many :outlets, :dependent => :destroy
  belongs_to :city
end
