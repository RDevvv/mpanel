class Area < ActiveRecord::Base
  attr_accessible :area_name, :city_id, :latitude, :longitude, :city_name
  has_many :accounts, :dependent => :destroy
  has_many :outlets, :dependent => :destroy
  has_many :area_pincodes, :dependent => :destroy
  has_many :pincodes, :through => :area_pincodes
  belongs_to :city
  geocoded_by :area_name   # can also be an IP address
	after_validation :geocode #, :if => :address_changed?
  validates_presence_of :area_name
  scope :by_area_name ,lambda {|name| where("LOWER(areas.area_name) = ?",name.downcase.strip)}
  scope :by_name,lambda {|name| where("areas.area_name ilike ?","%#{name}%") if name.present?}
  scope :by_pincode,lambda {|pincode| joins(:pincodes).where("pincodes.pincode = ?",pincode) if pincode.present?}

  def name
    area_name
  end
	
end
