class AdKeyword < ActiveRecord::Base
  attr_accessible :ad_id, :keyword_id
  belongs_to :ad
  belongs_to :keyword
end
