class Keyword < ActiveRecord::Base
  
  attr_accessible :ad_ids, :keyword, :keyword_alias,:attachments_attributes
  has_many :ad_keywords, :dependent => :destroy
  has_many :ads, :through => :ad_keywords
  has_many :keyword_aliases, :dependent => :destroy
 
  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :attachments ,allow_destroy: true

end
