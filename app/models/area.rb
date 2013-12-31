class Area < ActiveRecord::Base
  attr_accessible :area_name, :city_id, :latitude, :longitude, :city_name,:pincode
  has_many :accounts, :dependent => :destroy
  has_many :outlets, :dependent => :destroy
  belongs_to :city
  

  geocoded_by :area_address  # can also be an IP address
	after_validation :geocode , :if => :address_changed?
  validates_presence_of :area_name
  scope :by_area_name ,lambda {|name| where("LOWER(areas.area_name) = ?",name.downcase.strip)}
  scope :by_name,lambda {|name| where("areas.area_name ilike ?","%#{name}%") if name.present?}
  # scope :by_pincode,lambda {|pincode| joins(:pincodes).where("pincodes.pincode = ?",pincode) if pincode.present?}
  scope :by_pincode,lambda {|pincode|where("pincode = ?",pincode) if pincode.present?}

  def area_address
    [self.area_name, self.city.city_name, self.pincode].compact.join(', ')
    # [self.area_name, self.city.name, self.pincode,self.city.country.country_name].compact.join(', ')
  end

  def address_changed?
    area_name_changed? || city_id_changed? || pincode_changed?
  end

  def name
    area_name
  end

  def country
    city.country
  end
  
 
	
end
