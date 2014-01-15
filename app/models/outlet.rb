require 'csv'

class Outlet < ActiveRecord::Base

  attr_accessible :account_brand_id, :address, :area_id, :email_id, :is_active, :is_verified, :shop_no
  attr_accessible :latitude, :longitude, :mobile_number, :outlet_key, :phone_number, :deleted_at

  has_many :ads,:through=>:ad_promocode_outlets
  has_many :button_clicks
  belongs_to :area
  belongs_to :account_brand
  has_many :ad_promocode_outlets,:dependent=>:destroy
  has_many :ad_promocodes,:through=>:ad_promocode_outlets

  has_paper_trail
  acts_as_paranoid
  validates :mobile_number, :format => { :with => /^[7-9]\d{9}$/,:message => "Invalid Mobile Number" } ,:allow_nil => true, :allow_blank => true
  validates :email_id, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Invalid Email Id" } ,:allow_nil => true, :allow_blank => true
	validates :phone_number,  :format=>{:with =>  /^[0-9]\d{1,4}-\d{6,8}$/, :message => "Invalid!,it should be in the format of [Code]-[Number]" },:allow_nil => true, :allow_blank => true
  validates_uniqueness_of :outlet_key
  validates_presence_of  :address
  validates_presence_of :account_brand, :area
  after_save :geocode,:if => :is_address_changed?
  after_create :add_uniq_outlet_key
  geocoded_by :geocoding_address
  
  scope :active_outlets ,lambda { where("is_active = ?",true)}

  def toggle_active
    self.is_active? ?  self.deactivate : self.activate
  end

  def activate
    self.is_active = true
    self.save
  end

  def deactivate
    self.is_active = false
    self.save
  end

  def toggle_verify
    self.is_verified? ?  self.deactivate_verify : self.activate_verify
  end

  def activate_verify
    self.is_verified = true
    self.save
  end

  def deactivate_verify
    self.is_verified = false
    self.save
  end

  def cleanup_landline
    if self.phone_number.present? 
      self.phone_number.slice!(0) if self.phone_number.match(/^[0]/)
      self.phone_number.gsub!(/-/,"")
    end
  end

  def is_address_changed?
    address_changed? ||  area_id_changed?
  end

  def geocoding_address
    [self.address, self.area.area_name, self.area.city.name].compact.join(', ')
  end
  def full_address
    [self.area.city.name, self.area.name,self.shop_no, self.address].join(",")
  end

  def add_uniq_outlet_key
    self.outlet_key = rand.to_s[2..7]
    if self.valid?
      self.save
    else
      add_uniq_outlet_key
    end
    
  end

  def lat
    self.latitude || self.area.latitude || self.city.latitude
  end

  def long
     self.longitude || self.area.longitude || self.city.longitude
  end

  def self.import(file,account_brand_id)
    current_file = file.open
    csv_text = File.read(current_file)
    csv = CSV.parse(csv_text, :headers => true)
    invalid_records = Array.new
    valid_records = Array.new
    attempts = 0
    csv.each do |row|
      begin
        attempts += 1
        i= Outlet.create!(:account_brand_id=> account_brand_id,
        :outlet_type_id=>row[0],
        :address => row[1],
        :shop_no => row[2],
        :area_id => row[3],
        :phone_number => row[4],
        :mobile_country_id => row[5],
        :mobile_number => row[6],
        :email_id=> row[7]
        )
        valid_records.push(row)
      rescue
        puts "Exception Occured"
        invalid_records.push(row)
        puts invalid_records
      end
    end
    return valid_records,invalid_records
  end

  def self.show_records(file,account_brand_id)
    current_file = file.open
    csv_text = File.open(current_file,"r:ISO-8859-1")
    csv = CSV.parse(csv_text, :headers => true)
    records = Array.new
    invalid_records = []
    valid_records = []
    csv.each do |row|
      records << row.to_a.collect{|x|x[1]}
    end
    records
  end

  def self.get_closest_city(city_name=nil,area_name=nil,pincode=nil)
    city = nil

    cities = City.by_name(city_name) if city_name.present?
    pincode_areas = Area.by_pincode(pincode)  if pincode.present?
    areas = Area.by_name(area_name)  if area_name.present?
    if cities.present?
      city = cities.first
    elsif  pincode_areas.present?
      city = picode_areas.first.city
    elsif areas.present?
      city = areas.first.city
    end
    city
  end

  def self.import_record(params)
    city = City.find(params[:city_id])
    account_brand = AccountBrand.find(params[:account_brand_id])
    area = city.areas.by_name(params[:area_name]).by_pincode(params[:pincode]).first
    area = city.areas.create!(:area_name=>params[:area_name],:pincode=>params[:pincode]) if area.blank?
    outlet = account_brand.outlets.new(params[:outlet])
    outlet.area_id = area.id
    outlet.is_active = true
    outlet.save
    outlet
  end

  def get_brands
    brands = Array.new
    self.ads.each do |ad|
      brands.push ad.account_brand.brand
    end
    brands.uniq
  end

  def sort_by_brands(brand_id)
    outlets = Array.new
    Brand.find(brand_id).account_brands.each do |account_brand|
      account_brand.ads.each do |ad|
        outlets.push ad.outlets
      end
    end
    outlets = outlets.flatten.uniq
  end
end
