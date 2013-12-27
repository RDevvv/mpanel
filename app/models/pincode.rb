class Pincode < ActiveRecord::Base
  attr_accessible :pincode
  has_many :area_pincodes, :dependent => :destroy
  has_many :areas, :through => :area_pincodes
  scope :by_pincode,lambda {|pincode|where(:pincode=>pincode)}
end
