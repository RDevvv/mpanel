class Pincode < ActiveRecord::Base
  attr_accessible :pincode
  has_many :area_pincodes, :dependent => :destroy
  has_many :areas, :through => :area_pincodes
  has_many :cities,:through=>:areas
  scope :by_pincode,lambda {|pincode|where("pincodes.pincode = ?",pincode)}
end
