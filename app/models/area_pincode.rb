class AreaPincode < ActiveRecord::Base
  attr_accessible :area_id, :pincode_id
  belongs_to :pincode
  belongs_to :area
end
