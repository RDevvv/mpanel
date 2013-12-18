class Outlet < ActiveRecord::Base

  attr_accessible :account_brand_id, :address, :area_id, :email_id, :is_active, :is_verified
  attr_accessible :latest_version_id, :latitude, :longitude, :mobile_country_id, :mobile_number
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

  after_validation :geocode
  geocoded_by :geocoding_address

  def geocoding_address
      self.address
  end

  
  def self.import(file)
    require 'csv'
    # CSV.foreach(file.path, headers: true) do |row|
 
    #   outlet_hash = row.to_hash # exclude the price field
    #   outlet = Outlet.where(id: outlet_hash["id"])
 
    #   if outlet.count == 1
    #     outlet.first.update_attributes(outlet_hash)
    #   else
    #     Outlet.create!(outlet_hash)
    #   end # end if !product.nil?
    # end # end CSV.foreach
    
    current_file = file.open
    csv_text = File.read(current_file)
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Outlet.create!(:latest_version_id=>row[0],
      :account_brand_id=> row[1],
      :outlet_type_id=>row[2],
      :address => row[3],
      :area_id => row[4],
      :phone_number => row[5],
      :mobile_country_id => row[6],
      :mobile_number => row[7],
      :email_id=> row[8],
      :is_active=> row[9],
      :is_verified => row[10],
      :latitude=>row[11],
      :longitude=> row[12],
      :outlet_key => row[13]
      )  
    end

  end # end self.import(file)
end
