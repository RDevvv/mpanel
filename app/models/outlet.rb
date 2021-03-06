require 'csv'

$previous_brands = Hash.new
class Outlet < ActiveRecord::Base

    attr_accessor :new_distance
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
	# validates :phone_number,  :format=>{:with =>  /^[0-9]\d{1,4}-\d{6,8}$/, :message => "Invalid!,it should be in the format of [Code]-[Number]" },:allow_nil => true, :allow_blank => true
  validates :phone_number, :numericality => {:greater_than => 0, :message => " is an invalid Phone Number."},:allow_nil => true, :allow_blank => true
  validates_uniqueness_of :address, :scope => [:shop_no,:area_id], message: "Record Already Exist.."
 #  validates_uniqueness_of :outlet_key
 #  validates_presence_of  :address
 #  validates_presence_of :account_brand, :area

  after_save :geocode,:if => :is_address_changed?
  after_save :is_outlet_verified

  after_create :add_uniq_outlet_key

  geocoded_by :geocoding_address

  scope :active_outlets ,lambda { where("is_active = ?",true)}

  def is_outlet_verified
    if self.latitude.present? && self.longitude.present?
      self.update_column(:is_verified,true)
    else
      self.update_column(:is_verified,false)
    end
  end

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
        invalid_records.push(row)
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
      city = pincode_areas.first.city
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

 # def sort_by_brands(brand_id)
 #   outlets = Array.new
 #   Brand.find(brand_id).account_brands.each do |account_brand|
 #     account_brand.ads.each do |ad|
 #       outlets.push ad.outlets
 #     end
 #   end
 #   outlets = outlets.flatten.uniq
 # end

  def self.get_coordinates(location,longitude,latitude)
      latitude = latitude.to_f
      longitude = longitude.to_f
      coordinates = {:latitude => nil, :longitude => nil}
      if(latitude == 0 && longitude== 0)
          result = Geocoder.search(location+" india")
          unless result.empty?
              @location = result.first.data["geometry"]["location"]
              coordinates[:latitude] = @location["lat"]
              coordinates[:longitude] = @location["lng"]
          end
      else
          coordinates[:latitude] = latitude
          coordinates[:longitude] = longitude
      end
      return coordinates
  end

  def self.sort_outlet_by_ad_presence(outlets)
      @outlets_with_ad = Array.new
      @outlets_without_ad = Array.new
      outlets_with_ad_index = 0
      outlets_without_ad_index = 0

      outlets.each do |outlet|
          if outlet.is_active == true
              if (outlet.ads.empty? && outlet.ads.map{|ad|ad.promocode_available?.include?(true)})||(outlet.ads.map{|ad|ad.expired?}.include?(true))
                  @outlets_without_ad[outlets_without_ad_index] = outlet
                  outlets_without_ad_index +=1
              else
                  @outlets_with_ad[outlets_with_ad_index] = outlet
                  outlets_with_ad_index +=1
              end
          end
      end
      #return (@outlets_with_ad+@outlets_without_ad)    ## Use this statement if outlets without ads need to be returned
      return (@outlets_with_ad)
  end

  def self.discard_outlets_from_same_brand(outlets,previous_brands)
      final_outlets = Array.new
      brands = outlets.map{|o|o.get_brand.brand_name}.uniq.map{|brand|[brand,0]}.flatten
      brands = Hash[*brands]
      previous_brands = brands.merge(previous_brands)
      outlets.each do |outlet|
          outlet_brand = outlet.get_brand.brand_name
          previous_brands[outlet_brand] += 1
          final_outlets.push(outlet) if previous_brands[outlet_brand] == 1
      end
      [final_outlets, previous_brands]
  end

  def get_brand
      self.account_brand.brand
  end

  def get_address
      if self.shop_no.blank?
          shop_no = " "
      else
          shop_no = self.shop_no
      end

      shop_no+" "+self.address+"<br /> "+self.area.area_name+"<br /> "+self.area.city.city_name+", "+self.area.pincode
  end

  def self.nearby_outlet_ids(outlets)
      unless outlets.blank?
          nearby_outlets = outlets.map{|o| o.id}.uniq
      else
          nearby_outlets = []
      end
      nearby_outlets
  end

  def self.sort_by_distance_and_presence(result,outlets)
      nearby_outlets = Outlet.nearby_outlet_ids(outlets)
      unless result.blank?
          new_outlets = Outlet.where(:id => 0)
          ad_outlets = result.map{|ad|ad.outlets}.flatten.map{|outlet|outlet.id}.uniq
          nearby_outlets_with_ad = ad_outlets&nearby_outlets
          nearby_outlets_with_ad.map {|outlet_id| new_outlets.append(outlets.find(outlet_id))} unless nearby_outlets_with_ad.empty?
          final_outlets = new_outlets.sort {|x,y| x.distance <=> y.distance}.uniq
          ad_ids = result.map{|ad|ad.id}
      end
      [final_outlets,ad_ids]
  end

  def self.get_poster_data(outlets, customer_uuid)
      outlets_with_ads, outlets_without_ads = Array.new, Array.new
      @ad_likes = Customer.where(:uuid => customer_uuid).first.ad_likes.flatten

      outlets.each do |outlet|
        distance = outlet.get_distance
        brand = outlet.account_brand.brand
        if outlet.doesnt_have_ads
          outlets_without_ads += [:brand_image => Ad.get_image(0,outlet), :brand_id => brand.id, :facebook_handle => brand.facebook_handle, :twitter_handle => brand.twitter_handle, :twitter_followers_count => brand.twitter_followers_count, :facebook_likes_count => brand.facebook_likes_count, :is_unlocked => false, :ad_id => 0, :ad_title => nil, :sms_text => nil, :outlet_id => outlet.id, :distance => distance, :area_name => outlet.area.area_name, :city_name => outlet.area.city.city_name, :pincode => outlet.area.pincode, :latitude => outlet.latitude, :longitude => outlet.longitude, :shop_no => outlet.shop_no, :poster_address => outlet.get_address, :address => outlet.address, :mobile_number => outlet.mobile_number, :phone_number => outlet.phone_number, :ad_is_exclusive => false, :brand_name => outlet.account_brand.brand.brand_name, :brand => outlet.account_brand.brand, :ad_usage => -1, :ad_expiry_date => Date.today+100.years]
        else
          ads = outlet.select_ads
          ads.each do |ad|
            is_unlocked = ad.is_unlocked(@ad_likes)
            outlets_with_ads += [:brand_image => Ad.get_image(ad,outlet), :brand_id => brand.id, :facebook_handle => brand.facebook_handle, :twitter_handle => brand.twitter_handle, :twitter_followers_count => brand.twitter_followers_count, :facebook_likes_count => brand.facebook_likes_count, :is_unlocked => is_unlocked, :ad_id => ad.id, :ad_title => ad.ad_title, :sms_text => ad.sms_text, :outlet_id => outlet.id, :distance => distance, :area_name => outlet.area.area_name, :city_name => outlet.area.city.city_name, :pincode => outlet.area.pincode, :latitude => outlet.latitude, :longitude => outlet.longitude, :shop_no => outlet.shop_no, :poster_address => outlet.get_address, :address => outlet.address, :mobile_number => outlet.mobile_number, :phone_number => outlet.phone_number, :ad_is_exclusive => ad.is_exclusive, :brand_name => brand.brand_name, :brand => brand, :ad_usage => ad.usage, :ad_expiry_date => ad.expiry_date]
          end
        end
      end
      outlets_with_ads+outlets_without_ads
  end

  def select_ads
    ads = self.ads.select{|ad|(ad.expired? == false)&(ad.promocode_available?)}.select{|ad|ad.check_day.include?(Date.today.wday)}
    ads
  end

  def doesnt_have_ads
    if (self.ads.empty? && self.ads.map{|ad|ad.promocode_available?.include?(true)})||(self.ads.map{|ad|ad.expired?}.include?(true))
      return true
    end
  end

  def get_distance
    distance =0
    distance = self.distance.to_f.round(2) if self.new_distance.nil?
    distance
  end
end
