class Pincode < ActiveRecord::Base
  attr_accessible :pincode
  has_many :area_pincodes, :dependent => :destroy
  has_many :areas, :through => :area_pincodes
  has_many :cities,:through=>:areas
  validates :pincode ,:presence => true,
            :length => { :within => 5..6 },
            :numericality => { :only_integer => true }
  scope :by_pincode,lambda {|pincode|where("pincodes.pincode = ?",pincode)}
end
