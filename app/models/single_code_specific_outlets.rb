class SingleCodeSpecificOutlets < ActiveRecord::Base
  attr_accessible :outlet_ad_id, :end_date, :is_deleted, :promocode, :start_date
  belongs_to :outlet_ad
end
