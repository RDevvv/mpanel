require 'csv'

class Outlet < ActiveRecord::Base

  attr_accessible :account_brand_id, :address, :area_id, :email_id, :is_active, :is_verified
  attr_accessible :latitude, :longitude, :mobile_country_id, :mobile_number
  attr_accessible :outlet_key, :outlet_type_id, :phone_number, :outlet_views, :outlet_calls, :outlet_impressions

  has_many :outlet_versions
  has_many :ads,:through=>:ad_promocode_outlets
  belongs_to :area
  belongs_to :account_brand
  belongs_to :outlet_type
  has_many :ad_promocode_outlets,:dependent=>:destroy
  has_many :ad_promocodes,:through=>:ad_promocode_outlets

  has_paper_trail
  #acts_as_paranoid
  validates :mobile_number, :format => { :with => /^[0-9\-\+]{9,15}$/,:message => "Invalid Mobile Number" } ,:allow_nil => true, :allow_blank => true
  validates :email_id, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "Invalid Email Id" } ,:allow_nil => true, :allow_blank => true
	validates :phone_number,  :numericality => {:greater_than => 0, :message => " is an invalid number."}   ,:allow_nil => true, :allow_blank => true

  validates_presence_of :account_brand, :area
  after_save :geocode,:if => :address_changed?
  geocoded_by :geocoding_address

  def geocoding_address
    [self.address, self.area.area_name, self.area.city.name, self.area.pincode,self.area.city.state.state_name,self.area.city.state.country.country_name].compact.join(', ')
  end
  

  def lat
  end

  def long
    
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
        :area_id => row[2],
        :phone_number => row[3],
        :mobile_country_id => row[4],
        :mobile_number => row[5],
        :email_id=> row[6]
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
    csv_text = File.read(current_file)
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
    picode_areas = Area.by_pincode(pincode)  if pincode.present?
    areas = Area.by_name(area_name)  if area_name.present?
    if cities.present?
      city = cities.first
    elsif  picode_areas.present?
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
    area = city.areas.create(:area_name=>params[:area_name],:pincode=>params[:pincode]) if area.blank?
    outlet = account_brand.outlets.new(params[:outlet])
    outlet.area_id = area.id
    outlet.save
    outlet
  end



end
