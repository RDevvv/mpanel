class SingleCodeAnyOutlet < ActiveRecord::Base
  attr_accessible :ad_id, :end_date, :is_deleted, :promocode, :start_date
  belongs_to :ad
end
